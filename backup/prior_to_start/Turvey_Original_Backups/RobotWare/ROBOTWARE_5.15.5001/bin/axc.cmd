### Start base services initialization
#
baseinit

task -slotname elog_axcts -slotid 8 -pri 45 -vwopt 0x1c -stcks 9000 -entp elog_axcts -auto
synchronize -level task
go -level task

invoke -entry axcpcidevs_setup_all -nomode

task -slotname netcmd_axc -pri 140 -vwopt 0x1c -stcks 5000 -entp netcmdts_rcl -auto -nosync

wait_for_mc_synch_cmd

basenew
### Finished base services initialization
#

### Start MOC elog 
invoke -entry axc_elog_init -nomode
task -slotname AXC_ELOGTS -slotid 1 -pri 35 -vwopt 0x1c -stcks 9000 -entp axc_elogts -auto
synchronize -level task
go -level task
invoke -entry axc_elog_new  -nomode

task -slotname MCOM_AXCTS -slotid 5 -pri 55 -vwopt 0x1c -stcks 6000 -entp mcom_axcts -auto
task -slotname SUPERVISION -slotid 6 -pri 50 -vwopt 0x1c -stcks 7000 -entp supervisionts -auto
task -slotname AXC_SYSTEMTS -slotid 4 -pri 40 -vwopt 0x1c -stcks 18000 -entp axc_systemts -auto
task -slotname EVENT_SCHED -slotid 9 -pri 30 -vwopt 0x1c -stcks 7000 -entp event_schedulerts -auto
task -slotname SEND_FDBTS -slotid 3 -pri 25 -vwopt 0x1c -stcks 7000 -entp send_fdbts -auto
task -slotname REC_REFTS -slotid 2 -pri 20 -vwopt 0x1c -stcks 9000 -entp receive_refts -auto

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



