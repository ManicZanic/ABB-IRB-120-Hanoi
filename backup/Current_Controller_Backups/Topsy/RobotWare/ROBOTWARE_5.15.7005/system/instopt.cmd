# Install Options

getkey -id "Option" -var 1 -strvar $ANSWER -errlabel END_OF_LOOP
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERDesc"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel END_OF_LOOP
mediaexist -id $TEMP2 -label CONFIG_NEXT
goto -label LOAD_OPTION
#LOAD_OPTION
selectmedia -strvar $ANSWER -label CONFIG_NEXT
echo -text "Error installing $TEMP1 : $ANSWER"
goto -label CONFIG_NEXT
#END_OF_LOOP
setvar -var 2 -value 0
goto -label END_OF_FILE
#CONFIG_NEXT
addvar -var 1 -value 1
#END_OF_FILE
