# Robot install.cmd script for IRC5 
#
#
# Install questions
#    var 1  = irb type
#    var 2  = mounting type
#    var 3  = irb variant
#    var 10 = temp use.
echo -text ""
echo -text "IRB 120 family"

setvar -var 10 -value 0
getkey -id "Irb1Desc" -var 10 -strvar $IRBDESC -errlabel NODESC
echo -text "Installing $IRBDESC"
#NODESC
getkey -id "Irb1Select" -var 10 -strvar $ANSWER -errlabel ERROR
goto -strvar $ANSWER

#IRB120
config -filename  $BOOTPATH/irbcfg/SEC_120_0.58_3_1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/irbcfg/INT_120_0.58_3_1.cfg -domain MOC -internal
config -filename  $BOOTPATH/irbcfg/EXT_120_0.58_3_1.cfg -domain MOC
getkey -id "PSC_DRV_1" -var 10 -strvar $DUMMY -errlabel END_LABEL
copy -from $BOOTPATH/irbcfg/PSC_120_0.58_3_1.sxml -to $OPTIONS/PSC/psc_irobot_1.sxml
goto -label END_LABEL
#IRB120T
config -filename  $BOOTPATH/irbcfg/SEC_120T_0.58_3_1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/irbcfg/INT_120T_0.58_3_1.cfg -domain MOC -internal
config -filename  $BOOTPATH/irbcfg/EXT_120T_0.58_3_1.cfg -domain MOC
getkey -id "PSC_DRV_1" -var 10 -strvar $DUMMY -errlabel END_LABEL
copy -from $BOOTPATH/irbcfg/PSC_120T_0.58_3_1.sxml -to $OPTIONS/PSC/psc_irobot_1.sxml
goto -label END_LABEL
#ERROR
echo -text "Error when installing robot files"
goto -label END_LABEL
#END_LABEL
