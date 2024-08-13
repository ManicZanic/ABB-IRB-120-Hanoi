# Install.cmd script Calibration Pendelum
# Site dependent default config files
echo -text "Installing Calibration Pendelum"

config -filename  $BOOTPATH/calpend_sys.cfg -domain SYS -internal
config -filename  $BOOTPATH/calpend_mmc.cfg -domain MMC 

include -path "$RELEASE/system/instlang.cmd"

#END_LABEL
