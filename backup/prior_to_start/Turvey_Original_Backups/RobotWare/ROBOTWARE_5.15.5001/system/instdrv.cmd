# Install Drive Systems

#DRV1
getkey -id "Drive1" -var 1 -strvar $ANSWER -errlabel TRY_NEXT
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERSelect"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel TRY_NEXT
mediaexist -id $TEMP2 -label CONFIG_NEXT
#CONFIG_NEXT
config -filename $RELEASE/system/loc_saf_drv1.cfg -domain EIO -internal
selectmedia -strvar $ANSWER -label DRV2
echo -text "Could not install $TEMP1 : $ANSWER"
goto -label TRY_NEXT
#TRY_NEXT
#DRV2
getkey -id "Drive2" -var 1 -strvar $ANSWER -errlabel TRY_NEXT
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERSelect"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel TRY_NEXT
mediaexist -id $TEMP2 -label CONFIG_NEXT
#CONFIG_NEXT
config -filename $RELEASE/system/loc_saf_drv2.cfg -domain EIO -internal
selectmedia -strvar $ANSWER -label DRV3
echo -text "Could not install $TEMP1 : $ANSWER"
goto -label TRY_NEXT
#TRY_NEXT
#DRV3
getkey -id "Drive3" -var 1 -strvar $ANSWER -errlabel TRY_NEXT
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERSelect"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel TRY_NEXT
mediaexist -id $TEMP2 -label CONFIG_NEXT
#CONFIG_NEXT
config -filename $RELEASE/system/loc_saf_drv3.cfg -domain EIO -internal
selectmedia -strvar $ANSWER -label DRV4
echo -text "Could not install $TEMP1 : $ANSWER"
goto -label TRY_NEXT
#TRY_NEXT
#DRV4
getkey -id "Drive4" -var 1 -strvar $ANSWER -errlabel END_LABEL
setvar -var 10 -value 0
setstr -strvar $TEMP1 -value "$ANSWERSelect"
getkey -id $TEMP1 -var 10 -strvar $TEMP2 -errlabel END_LABEL
mediaexist -id $TEMP2 -label CONFIG_NEXT
#CONFIG_NEXT
config -filename $RELEASE/system/loc_saf_drv4.cfg -domain EIO -internal
selectmedia -strvar $ANSWER -label END_LABEL
echo -text "Could not install $TEMP1 : $ANSWER"
goto -label END_LABEL
#END_LABEL
