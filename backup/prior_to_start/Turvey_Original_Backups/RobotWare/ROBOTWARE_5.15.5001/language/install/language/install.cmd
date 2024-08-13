#Installation of language dependant files

setstr -strvar $TXTPATH -value $BOOTPATH/../$LANG/Controller

fileexist -path $TXTPATH/Rapid/roloptext.xml -label INSTALL_FILE
goto -label NEXT_FILE
#INSTALL_FILE
text -filename $TXTPATH/Rapid/roloptext.xml -package $LANG
#NEXT_FILE
