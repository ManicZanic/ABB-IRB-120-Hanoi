if -var 86 -value 10 -label END_LABEL
echo -text "--> Installing Motor Commutation Service Routine..."

config -filename $BOOTPATH/motcom_sys.cfg -domain SYS -internal
config -filename $BOOTPATH/motcom_mmc.cfg -domain MMC -internal

include -path "$RELEASE/system/instlang.cmd"

echo -text "--> ...Motor Commutation installation finished"
setvar -var 86 -value 10
#END_LABEL

