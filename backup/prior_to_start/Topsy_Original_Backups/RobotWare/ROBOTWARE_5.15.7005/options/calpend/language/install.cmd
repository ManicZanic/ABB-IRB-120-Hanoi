# Install_lang.cmd script Calibration Pendelum
# Site dependent default config files

fileexist -path $BOOTPATH/language/$LANG/calpender.xml -label INSTALL_FILE
goto -label NEXT_FILE
#INSTALL_FILE
text -filename $BOOTPATH/language/$LANG/calpender.xml -package $LANG
#NEXT_FILE
fileexist -path $BOOTPATH/language/$LANG/calpendop.xml -label INSTALL_FILE
goto -label END
#INSTALL_FILE
text -filename $BOOTPATH/language/$LANG/calpendop.xml -package $LANG
#END