# Install_lang.cmd script Motor Commutation
# Site dependent default config files

fileexist -path $BOOTPATH/language/$LANG/motcomop.xml -label INSTALL_FILE
goto -label END
#INSTALL_FILE
text -filename $BOOTPATH/language/$LANG/motcomop.xml -package $LANG
#END