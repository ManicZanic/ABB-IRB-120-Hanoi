# Install.cmd script for text files
#

# Rapid Language Text Registration
include -path "$RELEASE/system/instlang.cmd"


# Elog Language Text Registration
register -new -type elogtext -file elogtext_registry.xml
register -type elogmes -domain_no 1 -min 2 -max 174 -prepath $BOOTPATH/../ -postpath /Controller/Elog/opr_elogtext_1.xml
register -type elogmes -domain_no 1 -min 175 -max 1229 -prepath $BOOTPATH/../ -postpath /Controller/Elog/opr_elogtext_2.xml
register -type elogmes -domain_no 1 -min 1230 -max 2514 -prepath $BOOTPATH/../ -postpath /Controller/Elog/opr_elogtext_3.xml
register -type elogmes -domain_no 2 -min 10 -max 150 -prepath $BOOTPATH/../ -postpath /Controller/Elog/sys_elogtext_1.xml
register -type elogmes -domain_no 2 -min 153 -max 248 -prepath $BOOTPATH/../ -postpath /Controller/Elog/sys_elogtext_2.xml
register -type elogmes -domain_no 2 -min 249 -max 366 -prepath $BOOTPATH/../ -postpath /Controller/Elog/sys_elogtext_3.xml
register -type elogmes -domain_no 2 -min 367 -max 492 -prepath $BOOTPATH/../ -postpath /Controller/Elog/sys_elogtext_4.xml
register -type elogmes -domain_no 2 -min 493 -max 636 -prepath $BOOTPATH/../ -postpath /Controller/Elog/sys_elogtext_5.xml
register -type elogmes -domain_no 3 -min 1810 -max 4200 -prepath $BOOTPATH/../ -postpath /Controller/Elog/hw_elogtext_1.xml
register -type elogmes -domain_no 3 -min 4201 -max 7078 -prepath $BOOTPATH/../ -postpath /Controller/Elog/hw_elogtext_2.xml
register -type elogmes -domain_no 3 -min 7080 -max 7249 -prepath $BOOTPATH/../ -postpath /Controller/Elog/hw_elogtext_3.xml
register -type elogmes -domain_no 3 -min 7250 -max 9419 -prepath $BOOTPATH/../ -postpath /Controller/Elog/hw_elogtext_4.xml
register -type elogmes -domain_no 3 -min 9420 -max 9531 -prepath $BOOTPATH/../ -postpath /Controller/Elog/hw_elogtext_5.xml
register -type elogmes -domain_no 4 -min 1 -max 106 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_1.xml
register -type elogmes -domain_no 4 -min 107 -max 257 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_2.xml
register -type elogmes -domain_no 4 -min 258 -max 572 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_3.xml
register -type elogmes -domain_no 4 -min 573 -max 712 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_4.xml
register -type elogmes -domain_no 4 -min 713 -max 1010 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_5.xml
register -type elogmes -domain_no 4 -min 1011 -max 1476 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_6.xml
register -type elogmes -domain_no 4 -min 1477 -max 1583 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_7.xml
register -type elogmes -domain_no 4 -min 1584 -max 1701 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_8.xml
register -type elogmes -domain_no 4 -min 1702 -max 1807 -prepath $BOOTPATH/../ -postpath /Controller/Elog/arl_elogtext_9.xml
register -type elogmes -domain_no 5 -min 21 -max 183 -prepath $BOOTPATH/../ -postpath /Controller/Elog/moc_elogtext_1.xml
register -type elogmes -domain_no 5 -min 184 -max 279 -prepath $BOOTPATH/../ -postpath /Controller/Elog/moc_elogtext_2.xml
register -type elogmes -domain_no 5 -min 280 -max 366 -prepath $BOOTPATH/../ -postpath /Controller/Elog/moc_elogtext_3.xml
register -type elogmes -domain_no 5 -min 367 -max 444 -prepath $BOOTPATH/../ -postpath /Controller/Elog/moc_elogtext_4.xml
register -type elogmes -domain_no 7 -min 1001 -max 1231 -prepath $BOOTPATH/../ -postpath /Controller/Elog/io_elogtext_1.xml
register -type elogmes -domain_no 7 -min 1232 -max 1356 -prepath $BOOTPATH/../ -postpath /Controller/Elog/io_elogtext_2.xml
register -type elogmes -domain_no 7 -min 1357 -max 1450 -prepath $BOOTPATH/../ -postpath /Controller/Elog/io_elogtext_3.xml
register -type elogmes -domain_no 7 -min 1451 -max 1535 -prepath $BOOTPATH/../ -postpath /Controller/Elog/io_elogtext_4.xml
register -type elogmes -domain_no 8 -min 1 -max 3 -prepath $BOOTPATH/../ -postpath /Controller/Elog/usr_elogtext_1.xml
register -type elogmes -domain_no 10 -min 0 -max 0 -prepath $BOOTPATH/../ -postpath /Controller/Elog/int_elogtext_1.xml
register -type elogmes -domain_no 11 -min 4800 -max 4814 -prepath $BOOTPATH/../ -postpath /Controller/Elog/miscproc_elogtext_1.xml
register -type elogmes -domain_no 12 -min 1 -max 12 -prepath $BOOTPATH/../ -postpath /Controller/Elog/cfg_elogtext_1.xml
register -type elogmes -domain_no 15 -min 330 -max 330 -prepath $BOOTPATH/../ -postpath /Controller/Elog/rapid_elogtext_1.xml
register -type elogtitle -prepath $BOOTPATH/../ -postpath /Controller/Elog/domain_elogtitles.xml
register -type elogdomain -prepath $BOOTPATH/../ -postpath /Controller/Elog/elog_domains.xml


# UAS Text Language Registration
register -new -type uastext -file uastext_registry.xml
register -type uastext -domain "Builtin" -prepath $BOOTPATH/../ -postpath /Controller/uas/uastext.xml

# Cfg Text Language Registration
# Clear the registry file
register -new -type cfgtext -file cfgtext_registry.xml
# Note: Domains must match RobAPI's domains
#
getkey -id "PSCOption" -var 10 -strvar $ANSWER -errlabel NO_SAFEMOVE
ifstr -strvar $ANSWER -value "PREMIUM" -label SAFEMOVE
#NO_SAFEMOVE
register -type cfgtext -domain EIO -prepath $BOOTPATH/../ -postpath /Controller/Cfg/cir_eio_cfgtext.xml
goto -label NEXT
#SAFEMOVE
register -type cfgtext -domain EIO -prepath $BOOTPATH/../ -postpath /Controller/Cfg/cir_eio_sm_cfgtext.xml
#NEXT

register -type cfgtext -domain EIO -prepath $BOOTPATH/../ -postpath /Controller/Cfg/eio_cfgtext.xml
register -type cfgtext -domain SIO -prepath $BOOTPATH/../ -postpath /Controller/Cfg/sio_cfgtext.xml
register -type cfgtext -domain SYS -prepath $BOOTPATH/../ -postpath /Controller/Cfg/cir_sys_cfgtext.xml
register -type cfgtext -domain MOC -prepath $BOOTPATH/../ -postpath /Controller/Cfg/moc_cfgtext.xml
register -type cfgtext -domain MMC -prepath $BOOTPATH/../ -postpath /Controller/Cfg/cir_mmc_cfgtext.xml

getkey -id "MT" -var 10 -strvar $ANSWER -errlabel ST
goto -label END_ST
#ST
register -type cfgtext -domain SYS -prepath $BOOTPATH/../ -postpath /Controller/Cfg/cir_sys_st_cfgtext.xml
#END_ST

# Devices Text Language registration
register -type devices_text -prepath $BOOTPATH/../ -postpath /Controller/devices/SYS_devices_text.xml

goto -label NO_ERROR
#ERROR
echo -text "Error during installation of language: $LANG!"
#NO_ERROR
