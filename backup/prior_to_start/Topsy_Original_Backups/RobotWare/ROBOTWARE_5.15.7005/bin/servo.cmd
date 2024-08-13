### Start base services initialization
#
baseinit

### Enable override of EEPROM data for Axis Computer
# invoke2 -entry servoflash_overrides_execute -format voidvoid
# invoke2 -entry sysBspVersion -format voidvoid

### Load the DSP image and release the DSP
init_dsp

### The DSP need some time to setup the Ethernet link to the drive modules
delay -time 1000

### Detect drive units and do some basic setup
start_dsp

### Set the DSP in run mode
run_dsp

task -slotname elog_axcts -slotid 8 -pri 42 -vwopt 0x0 -stcks 9000 -entp elog_axcts -auto
synchronize -level task
go -level task

invoke -entry axcpcidevs_setup_all -nomode

### All errors so fas has been handled by code. From now on it should be handled in the script
onerror -action goto -label ERROR_BEFORE_MC_SYNC

### Setup drive unit link and collect HW and FW information from drive unit(s)
drive_unit_link_init

### Enable override of EEPROM data for Drive Units
# invoke2 -entry servoflash_drv_link_show -format voidvoid
# invoke2 -entry servoflash_drv_link_overrides_execute -format voidvoid
# invoke2 -entry servoflash_drv_link_show -format voidvoid

### From now on, lets quit if we get an error
onerror -action goto -label THE_END

task -slotname netcmd_axc -pri 80 -vwopt 0x0 -stcks 9000 -entp netcmdts_rcl -auto -nosync

### Wait for main computer synchronization command. 
wait_for_mc_synch_cmd

basenew

### Finished base services initialization
#

### Start MOC elog 
invoke -entry axc_elog_init -nomode
task -slotname AXC_ELOGTS -slotid 1 -pri 35 -vwopt 0x8 -stcks 9000 -entp axc_elogts -fpexc 0xd0 -auto
synchronize -level task
go -level task

invoke -entry axc_elog_new -noarg -nomode

task -slotname MCOM_AXCTS   -slotid 5 -pri 48 -vwopt 0x8 -stcks 6000 -entp mcom_axcts -fpexc 0xd0 -auto
task -slotname SUPERVISION  -slotid 6 -pri 45 -vwopt 0x8 -stcks 7000 -entp supervisionts -fpexc 0xd0 -auto
task -slotname AXC_SYSTEMTS -slotid 4 -pri 40 -vwopt 0x8 -stcks 18000 -entp axc_systemts -fpexc 0xd0 -auto
task -slotname EVENT_SCHED -slotid 9 -pri 30 -vwopt 0x8 -stcks 7000 -entp event_schedulerts -fpexc 0xd0 -auto
task -slotname SEND_FDBTS -slotid 3 -pri 25 -vwopt 0x8 -stcks 7000 -entp send_fdbts -fpexc 0xd0 -auto
task -slotname REC_REFTS -slotid 2 -pri 20 -vwopt 0x8 -stcks 9000 -entp receive_refts -fpexc 0xd0 -auto

### Enable DSP test code
# invoke2 -entry robocat_fiddler_enable -format voidvoid

synchronize -level task
go -level task
axc_init

### These arguments must be tested
invoke -entry	ref_buffer_init -arg 2 -arg2 5 -nomode
axc_new

#connect fpga isr to hook
routine_connect -routine scheduler_execute -connection FPGAINT_CONNECT

#connect fei isr to hook
routine_connect -routine scheduler_time_stamp -connection FEI_INTPOLL_CONNECT

# Tell that system startup is ready, now can the axc execute motion commands
invoke -entry axc_systemts_startup_ready -nomode

goto -label THE_END

### Error handling if we fail before MC-sync
### We need to sync to give information to the MC, e.g., elogs.
#ERROR_BEFORE_MC_SYNC

task -slotname netcmd_axc -pri 80 -vwopt 0x0 -stcks 9000 -entp netcmdts_rcl -auto -nosync

### Wait for main computer synchronization command. 
wait_for_mc_synch_cmd

basenew

### We're done
#THE_END

