# Install.cmd script for the IRC5 system 
# Option language config files

fileexist -path $BOOTPATH/language/$LANG/sis_txt.xml -label INSTALL_FILE
goto -label END
#INSTALL_FILE
text -filename $BOOTPATH/language/$LANG/sis_txt.xml -package $LANG
#END

