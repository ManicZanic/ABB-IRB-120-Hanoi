setvar -var 5 -value 0
setvar -var 7 -value 10
setstr -strvar $LANG -value "NULL"
loop -path "$RELEASE/system/instlang2.cmd" -var 7
