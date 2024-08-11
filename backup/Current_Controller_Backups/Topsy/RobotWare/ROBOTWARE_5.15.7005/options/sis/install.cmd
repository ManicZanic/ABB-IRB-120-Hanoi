# Install.cmd script for the IRC5 system 
# Option config files
if -var 58 -value 10 -label END_LABEL
echo -text "Installing Service Information System"
include -path "$RELEASE/system/instlang.cmd"
#append -from $BOOTPATH/opt_sis.cmd -to $INTERNAL/opt_l0.cmd
config -filename  $BOOTPATH/sissys.cfg -domain SYS -internal
config -filename  $BOOTPATH/sismmc.cfg -domain MMC -internal
setvar -var 58 -value 10
#END_LABEL
