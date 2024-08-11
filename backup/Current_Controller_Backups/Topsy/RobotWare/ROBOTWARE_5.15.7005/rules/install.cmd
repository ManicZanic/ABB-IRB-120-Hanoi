# Cfg Rules Registration

# Create the registry file in the system directory
register -new -type cfgrules -file cfgrules_registry.xml

setstr -strvar $CFGRULES -value $BOOTPATH/cfg/

# Register the rules for each of the cfg domains on the controller
# Note: The domain must appear exactly as the domain is created on the 
#       controller (cfg_new ("MOC") and as returned by RobAPI to a client.

getkey -id "PSCOption" -var 10 -strvar $ANSWER -errlabel NO_SAFEMOVE
ifstr -strvar $ANSWER -value "PREMIUM" -label SAFEMOVE
#NO_SAFEMOVE
register -type cfgrules -domain EIO -prepath $CFGRULES -postpath cir_eio_cfgrules.xml
goto -label NEXT
#SAFEMOVE
register -type cfgrules -domain EIO -prepath $CFGRULES -postpath cir_eio_sm_cfgrules.xml
#NEXT

register -type cfgrules -domain MOC -prepath $CFGRULES -postpath moc_cfgrules.xml
register -type cfgrules -domain EIO -prepath $CFGRULES -postpath eio_cfgrules.xml
register -type cfgrules -domain SIO -prepath $CFGRULES -postpath sio_cfgrules.xml
register -type cfgrules -domain SYS -prepath $CFGRULES -postpath cir_sys_cfgrules.xml
register -type cfgrules -domain MMC -prepath $CFGRULES -postpath cir_mmc_cfgrules.xml

getkey -id "MT" -var 10 -strvar $ANSWER -errlabel ST
goto -label END_ST
#ST
register -type cfgrules -domain SYS -prepath $CFGRULES -postpath CIR_SYS_ST_cfgrules.xml
#END_ST

# Devices struct registration

# Create the registry file in the system directory
register -new -type devices -file devices_registry.xml

# Register the devices struct file for RobotWare Kernel
register -type devices_struct -prepath $BOOTPATH/devices/ -postpath SYS_devices_struct.xml
