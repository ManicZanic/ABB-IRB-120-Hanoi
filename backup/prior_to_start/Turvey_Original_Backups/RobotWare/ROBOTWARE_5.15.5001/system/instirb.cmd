# Install Robots

setvar -var 10 -value 0
getkey -id "PSCOption" -var 10 -strvar $ANSWER -errlabel IRB1
direxist -path $OPTIONS/PSC -label PSC_UNPROTECT
mkdir -path $OPTIONS/PSC
#PSC_UNPROTECT
xattrib -path $OPTIONS/PSC/psc_irobot_*.sxml -attrs "-R"


#IRB1
getkey -id "Irb1" -var 1 -strvar $ANSWER -errlabel TRY_NEXT
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERDesc"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel TRY_NEXT
mediaexist -id $TEMP2 -label CONFIG_NEXT
#CONFIG_NEXT
setvar -var 10 -value 0
getkey -id "MM" -var 10 -strvar $MM -errlabel STD
goto -label MM
#STD
config -filename $RELEASE/system/tasksys.cfg -domain SYS
goto -label NEXT_STEP
#MM
config -filename $RELEASE/system/tasksys1.cfg -domain SYS
#NEXT_STEP
selectmedia -strvar $ANSWER -label IRB2
echo -text "Could not install $TEMP1 : $ANSWER"
goto -label TRY_NEXT

#TRY_NEXT
#IRB2
getkey -id "Irb2" -var 1 -strvar $ANSWER -errlabel TRY_NEXT
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERDesc"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel TRY_NEXT
mediaexist -id $TEMP2 -label CONFIG_NEXT
#CONFIG_NEXT
config -filename $RELEASE/system/tasksys2.cfg -domain SYS
selectmedia -strvar $ANSWER -label IRB3
echo -text "Could not install $TEMP1 : $ANSWER"
goto -label TRY_NEXT

#TRY_NEXT
#IRB3
getkey -id "Irb3" -var 1 -strvar $ANSWER -errlabel TRY_NEXT
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERDesc"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel TRY_NEXT
mediaexist -id $TEMP2 -label CONFIG_NEXT
#CONFIG_NEXT
config -filename $RELEASE/system/tasksys3.cfg -domain SYS
selectmedia -strvar $ANSWER -label IRB4
echo -text "Could not install $TEMP1 : $ANSWER"
goto -label TRY_NEXT

#TRY_NEXT
#IRB4
getkey -id "Irb4" -var 1 -strvar $ANSWER -errlabel END_LABEL
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERDesc"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel END_LABEL
mediaexist -id $TEMP2 -label CONFIG_NEXT
#CONFIG_NEXT
config -filename $RELEASE/system/tasksys4.cfg -domain SYS
selectmedia -strvar $ANSWER -label END_LABEL
echo -text "Could not install $TEMP1 : $ANSWER"
goto -label END_LABEL
#END_LABEL
