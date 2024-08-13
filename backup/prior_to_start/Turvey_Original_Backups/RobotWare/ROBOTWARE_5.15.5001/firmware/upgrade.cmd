#
# Property of ABB Vasteras/Sweden. All rights reserved.
# Copyright 2003.
#
# Upgrade.cmd script for 5.0
#
##silent

startup_log -file $INTERNAL/upgrade.log
invoke2 -entry trcrec_init -format int -int1 100000
baseinit

config -version 5 -revision 0

# Start event log
task -slotname elogts -slotid 1 -pri 90 -vwopt 0x1c -stcks 5000 -entp elog_main -auto

synchronize -level task
go -level task

invoke -entry fpgar11_init -errlabel ERROR

task -slotname delay_high -entp delay_ts -pri 60 -vwopt 0x1c -stcks 8000 -nosync -auto -wait_ready 10
task -slotname delay_medium -entp delay_ts -pri 78 -vwopt 0x1c -stcks 8000 -nosync -auto -wait_ready 10
task -slotname delay_low -entp delay_ts -pri 140 -vwopt 0x1c -stcks 8000 -nosync -auto -wait_ready 10

basenew

invoke -entry read_init

delay -time 10000

task -slotname elog_axctsr -pri 100 -vwopt 0x1c -stcks 7000 \
-entp elog_axctsr -auto -nosync

task -slotname axc_failts -slotid 28 -pri 80 -vwopt 0x1c -stcks 7000 -entp axc_failts -auto

synchronize -level task
go -level task

netcmd_run

echo -text "Upgrading Firmware start ..."

### Check AXC board firmware
invoke -entry netcmd_upgrade -arg 0 -strarg "axcfirmw_upgrade" -nomode

### Check MC board firmware
invoke -entry mcfirmw_upgrade -noarg -nomode

### Check if we use a paint panel board
setvar -var 10 -value 0
getkey -id "pib" -var 10 strvar $ANSWER -errlabel NO_PIB_SAF
echo -text "Paint Panel board is used."
invoke2 -entry fpgar11_start_fpga -format int -int1 1
goto -label PIB_SAF
#NO_PIB_SAF 
### Check PU board firmware
invoke2 -entry fpgar11_start_fpga -format int -int1 0
#PIB_SAF

### Check CB board and drive unit firmware
invoke -entry moc_io_new_upgrade -nomode
invoke -entry netcmd_upgrade -arg 1 -strarg "moc_io_upgrade" -nomode

### Check drive unit firmware (Drive system 09)
invoke -entry netcmd_upgrade -arg 0 -strarg "drive_unit_firmw_upgrade" -nomode

### Check PSU firmware
invoke -entry psu_upgrade -nomode

### Include any option/application specific upgrade scripts
fileexist -path $INTERNAL/upgrade_opt.cmd -label LOAD_CMD
goto -label NEXT_STEP
#LOAD_CMD
include -path $INTERNAL/upgrade_opt.cmd

#NEXT_STEP
echo -text "Upgrading Finished rebooting ..."

### Reset upgrade mode flag. Next restart is normal.
upgrade_mode_reset

systemrun
restart
delay -time 6000
# Make System Warmstart (use Startup.cmd)

