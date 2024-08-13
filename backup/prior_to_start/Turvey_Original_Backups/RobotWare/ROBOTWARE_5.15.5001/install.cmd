#
# Property of ABB Vasteras/Sweden. All rights reserved.
# Copyright 2002.
#
# Install.cmd script for 5.0
#
# Install questions
#    var 1  = Option loop
#    var 2  = Option loop
#    var 3  = irb variant
#    var 4  = trafo type
#    var 5  = Language loop
#    var 6  = 0 
#    var 7  = Language loop
#    var 9  = Query mode
#    var 10 = temp use.
#

startup_log -file $INTERNAL/install.log

# ##############  Base support initialization start. ###############################
basedefs -cfg 7000000 -tx 395000

ifvc -label VC_NO_TRCREC
invoke2 -entry trcrec_init -format int -int1 100000
#VC_NO_TRCREC

baseinit

# Initialize and enable system dump service
sysdmp_init -max_dumps 3 -delay 5000 -dir $INTERNAL/SYSDMP -compr no
ifvc -label VC_SKIP_SYSDMPTASK
task -slotname sysdmpts -slotid 82 -pri 253 -vwopt 0x1c -stcks 15000 -entp sysdmpts_main -auto
#VC_SKIP_SYSDMPTASK
sysdmp_add -show print_spooler_show_buffer

setstr -strvar $ANSWER -value "BootBase"
selectmedia -strvar $ANSWER -boot

config -version 5 -revision 0
# Early elog start
task -slotname elogts -slotid 1 -pri 90 -vwopt 0x1c -stcks 5000 -entp elog_main -auto
synchronize -level task
go -level task

task -slotname delay_high -entp delay_ts -pri 60 -vwopt 0x1c -stcks 8000 -nosync -auto -wait_ready 10
task -slotname delay_medium -entp delay_ts -pri 78 -vwopt 0x1c -stcks 8000 -nosync -auto -wait_ready 10
task -slotname delay_low -entp delay_ts -pri 140 -vwopt 0x1c -stcks 8000 -nosync -auto -wait_ready 10

# Add trace recorder to the system dump service
# sysdmp_add -class trcrec

basenew

ifvc -label NO_ATTRIB
attrib -path $SYSTEM/INTERNAL -attrs "+H"
#NO_ATTRIB

# ################ Base support initialization finished. #############################

init -resource eio
init -resource sio
init -resource motion
init -resource cab

echo -text "Installation start ..."

task -slotname cabts -slotid 17 -pri 100 -vwopt 0x1c -stcks 64000 \
-entp cabts_main -auto

#CONFIG_LOAD
# system defined config files
echo -text "Installing system config files"
config -filename $BOOTPATH/sys.cfg -domain SYS -internal

config -filename $BOOTPATH/eio_internal.cfg -domain EIO -internal
config -filename $BOOTPATH/eio_external.cfg -domain EIO
config -filename $BOOTPATH/sys_eiosig.cfg -domain EIO -internal
config -filename $BOOTPATH/loc_bus.cfg -domain EIO -internal
config -filename $BOOTPATH/loc_unit.cfg -domain EIO -internal

# Check if we use a paint panel board
setvar -var 10 -value 0
getkey -id "pib" -var 10 strvar $ANSWER -errlabel NO_PIB_SAF
echo -text "Paint Panel board is used."
goto -label PIB_SAF
#NO_PIB_SAF 
config -filename $BOOTPATH/loc_saf.cfg -domain EIO -internal
#PIB_SAF

config -filename  $BOOTPATH/pgmbtn.cfg -domain MMC  -internal
config -filename  $BOOTPATH/rlmset.cfg -domain MMC  -internal
config -filename  $BOOTPATH/rlmove.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlmsys.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlexe.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlcom.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlsocket.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlio.cfg -domain MMC -internal
config -filename  $BOOTPATH/rltrap.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlmmec.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlsys.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlload.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlmsrc.cfg -domain MMC -internal
config -filename  $BOOTPATH/rltrig.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlpid.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlsmod.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlfsta.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlraps.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlmath.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlmexe.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlsset.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlstr.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlcure.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlwz.cfg -domain MMC -internal
config -filename  $BOOTPATH/rltool.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlsym.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlbit.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlcal.cfg -domain MMC -internal

setvar -var 10 -value 0
getkey -id "paintMedia" -var 10 strvar $ANSWER -errlabel NO_PAINT_CNV
goto -label PAINT_CNV
#NO_PAINT_CNV 
config -filename  $BOOTPATH/rlcnv.cfg -domain MMC -internal
goto -label NEXT_STEP
#PAINT_CNV
config -filename  $BOOTPATH/rlcnv_pnt.cfg -domain MMC -internal

#NEXT_STEP
config -filename  $BOOTPATH/rlsc.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlind.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlcorr.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlopr.cfg -domain MMC -internal
config -filename  $BOOTPATH/rldata.cfg -domain MMC -internal
config -filename  $BOOTPATH/rlmq.cfg -domain MMC -internal
config -filename  $BOOTPATH/rltrigios.cfg -domain MMC -internal
config -filename  $BOOTPATH/mockit1.cfg -domain MMC -internal
config -filename  $BOOTPATH/usrmmc.cfg -domain MMC -internal
config -filename  $BOOTPATH/usrmmc_mc.cfg -domain MMC
config -filename  $BOOTPATH/bat_shutdownmmc.cfg -domain MMC -internal

config -filename  $BOOTPATH/rlbasic.cfg -domain SYS -internal
config -filename  $BOOTPATH/rldbg.cfg -domain SYS -internal
config -filename  $BOOTPATH/bat_shutdownsys.cfg -domain SYS -internal
config -filename  $BOOTPATH/runchn.cfg -domain SYS
config -filename  $BOOTPATH/runchn_e.cfg -domain SYS

# Electronically linked motors
copy -from $BOOTPATH/linked_m.sys -to $HOME/linked_m.sys
config -filename  $BOOTPATH/linked_m_2.cfg -domain SYS -internal
config -filename  $BOOTPATH/linked_m_1.cfg -domain MMC -internal

# Site dependent default config files
config -filename  $BOOTPATH/usrsys.cfg -domain SYS
config -filename  $BOOTPATH/rluser.cfg -domain SYS

config -filename  $BOOTPATH/com_int.cfg -domain SIO -internal
config -filename  $BOOTPATH/com_ext.cfg -domain SIO

synchronize -level task
go -level task

echo -text "Installing system files"

fileexist -path $INTERNAL/opt_l0.cmd -label CLEANUP_0
goto -label NEXT_STEP
#CLEANUP_0
delete -path $INTERNAL/opt_l0.cmd
#NEXT_STEP
fileexist -path $INTERNAL/option.cmd -label CLEANUP_1
goto -label NEXT_STEP
#CLEANUP_1
delete -path $INTERNAL/option.cmd
#NEXT_STEP
fileexist -path $INTERNAL/opt_l2.cmd -label CLEANUP_2
goto -label NEXT_STEP
#CLEANUP_2
delete -path $INTERNAL/opt_l2.cmd
#NEXT_STEP
fileexist -path $INTERNAL/opt_l3.cmd -label CLEANUP_3
goto -label NEXT_STEP
#CLEANUP_3
delete -path $INTERNAL/opt_l3.cmd
#NEXT_STEP
fileexist -path $INTERNAL/upgrade_opt.cmd -label CLEANUP_UPGRADE
goto -label NEXT_STEP
#CLEANUP_UPGRADE
delete -path $INTERNAL/upgrade_opt.cmd
#NEXT_STEP
fileexist -path $SYSTEM/service_debug.cmd -label CLEANUP_SERVDBG
goto -label NEXT_STEP
#CLEANUP_SERVDBG
delete -path $SYSTEM/service_debug.cmd
#NEXT_STEP
fileexist -path $SYSTEM/service_debug_early.cmd -label CLEANUP_SERVDBGE
goto -label NEXT_STEP
#CLEANUP_SERVDBGE
delete -path $SYSTEM/service_debug_early.cmd
#NEXT_STEP
fileexist -path $SYSTEM/service_debug_sysdmp.cmd -label CLEANUP_SERVDBGDMP
goto -label NEXT_STEP
#CLEANUP_SERVDBGDMP
delete -path $SYSTEM/service_debug_sysdmp.cmd
#NEXT_STEP

copy -from $BOOTPATH/startup.cmd -to $INTERNAL/startup.cmd
copy -from $BOOTPATH/user.sys -to $HOME/user.sys

setstr -strvar $ANSWER -value "Rules"
selectmedia -strvar $ANSWER -label NEXT_STEP
echo -text "Error installing rules"
goto -label ERROR

#NEXT_STEP
setstr -strvar $ANSWER -value "LanguageInstall"
selectmedia -strvar $ANSWER -label NEXT_STEP
echo -text "Error installing texts"
goto -label ERROR

#NEXT_STEP
fileexist -path $RELEASE/system/instdrv.cmd -label LOAD_CMD
goto -label ERROR
#LOAD_CMD
include -path $RELEASE/system/instdrv.cmd

#NEXT_STEP
setvar -var 10 -value 0
getkey -id "SkipIrb" -var 10 -strvar $ANSWER -errlabel IRB
echo -text "Skip install Irb"
goto -label CONFIG_NEXT

#IRB
fileexist -path $HOME/ext_instirb.cmd -label IRB_EXT_INSTALL
fileexist -path $RELEASE/system/instirb.cmd -label LOAD_CMD
goto -label ERROR
#LOAD_CMD
include -path $RELEASE/system/instirb.cmd
goto -label IRB_INSTALL

#IRB_EXT_INSTALL
include -path $HOME/ext_instirb.cmd
goto -label IRB_INSTALL

#IRB_INSTALL
config -filename $RELEASE/system/sec_system.cfg.enc -domain MOC -internal
config -filename $RELEASE/system/int_system.cfg -domain MOC -internal
config -filename $RELEASE/system/ext_system.cfg -domain MOC

#CONFIG_NEXT
register -new -type hw_compatibility -file hw_compatibility_registry.xml
register -new -type option -file option_registry.xml

register -type hw_compatibility -prepath $RELEASE/firmware/ -postpath hw_compatibility.xml

setvar -var 1 -value 0
setvar -var 2 -value 60
loop -path "$RELEASE/system/instopt.cmd" -var 2

setstr -strvar $ANSWER -value "ExtOpt"
selectmedia -strvar $ANSWER -option
#NEXT_STEP


setvar -var 10 -value 0
getkey -id "ExtCfg" -var 10 -strvar $CFGPATH -errlabel SYSPAR_DEF
goto -label SYSPAR
#SYSPAR_DEF
setstr -strvar $CFGPATH -value $SYSPAR 
#SYSPAR

fileexist -path $CFGPATH/moc.cfg -label ERASE_MOC
goto -label NEXT_ERASE_STEP
#ERASE_MOC
echo -text "Replacing domain MOC"
config -erase -domain MOC
config -filename $CFGPATH/moc.cfg -domain MOC

#NEXT_ERASE_STEP
fileexist -path $CFGPATH/eio.cfg -label ERASE_EIO
goto -label NEXT_ERASE_STEP
#ERASE_EIO
echo -text "Replacing domain EIO"
config -erase -domain EIO
config -filename $CFGPATH/eio.cfg  -domain EIO

#NEXT_ERASE_STEP
fileexist -path $CFGPATH/sio.cfg -label ERASE_SIO
goto -label NEXT_ERASE_STEP
#ERASE_SIO
echo -text "Replacing domain SIO"
config -erase -domain SIO
config -filename $CFGPATH/sio.cfg  -domain SIO

#NEXT_ERASE_STEP
fileexist -path $CFGPATH/mmc.cfg -label ERASE_MMC
goto -label NEXT_ERASE_STEP
#ERASE_MMC
echo -text "Replacing domain MMC"
config -erase -domain MMC
config -filename $CFGPATH/mmc.cfg  -domain MMC

#NEXT_ERASE_STEP
fileexist -path $CFGPATH/proc.cfg -label ERASE_PROC
goto -label NEXT_ERASE_STEP
#ERASE_PROC
echo -text "Replacing domain PROC"
config -erase -domain PROC
config -filename $CFGPATH/proc.cfg -domain PROC

#NEXT_ERASE_STEP
fileexist -path $CFGPATH/sys.cfg -label ERASE_SYS
goto -label NEXT_ERASE_STEP
#ERASE_SYS
echo -text "Replacing domain SYS"
config -erase -domain SYS
config -filename $CFGPATH/sys.cfg -domain SYS

#NEXT_ERASE_STEP
fileexist -path $CFGPATH/calib.cfg -label ADD_MOC
goto -label NEXT_STEP
#ADD_MOC
echo -text "Load calib file"
config -replace -filename $CFGPATH/calib.cfg -domain MOC

#NEXT_STEP
fileexist -path $HOME/ext_install.cmd -label LOAD_CMD
goto -label NEXT_STEP
#LOAD_CMD
echo -text "Include external installation file"
include -path $HOME/ext_install.cmd

#NEXT_STEP
ifvc -label NEXT_STEP
# Save a copy of system.xml if needed
fileexist -path $INTERNAL/system.xml -label NEXT_STEP
fileexist -path $SYSTEM/system.xml -label COPY_SYS_XML
echo -text "No system.xml exist in the SYSTEM folder"
goto -label NEXT_STEP
#COPY_SYS_XML
echo -text "Save a copy of system.xml"
copy -from $SYSTEM/system.xml -to $INTERNAL/system.xml

#NEXT_STEP
#VC_MOTION_SKIP
ifvc -label VC_MOC_NEW
goto -label RW_NO_MOC_NEW
#VC_MOC_NEW
new -resource motion
#RW_NO_MOC_NEW

new -resource cab
restart
ifvc -label NO_STOP_DELAY
delay -time 6000
#NO_STOP_DELAY
# Make System Warmstart (use Startup.cmd)
# A VC will continue to execute the script after restart
goto -label NO_ERROR
#ERROR
echo -text "Error during installation !"
echo -text "Please retry to install the system."
echo -text "Installing RAPID instruction sets"
ifvc -label NO_ERROR
rename -from $SYSTEM -to $SYSTEM_CORRUPT
delete -path /hd0a/system.dir
delay -time 1000
restart
#NO_ERROR


