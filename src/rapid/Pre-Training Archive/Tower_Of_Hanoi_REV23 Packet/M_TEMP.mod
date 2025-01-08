MODULE M_TEMP
    !    !*****************************************************
    !    !Module Name:   M_TEMPLATE
    !    !Version:       1.22
    !    !Description:   Temp
    !    !Date:          2024-08-30
    !    !Author:        @ManicZanic
    !    !
    !    !*****************************************************
    !    !Change Log:
    !    !2024-08-31:    @ManicZanic - Orignal core pulled from MainModule
    !    !*****************************************************
    
    PROC Temp()

        CONST listitem list{3}:=[["","Item 1"],["","Item 2"],["","Item 3"]];
        VAR num list_item;
        VAR btnres button_answer;

        list_item:=UIListView(\Result:=button_answer\Header:="UIListView Header",list\Buttons:=btnOKCancel\Icon:=iconInfo\DefaultIndex:=1);
        IF button_answer=resOK THEN
            IF list_item=1 THEN
                ! Do item1
            ELSEIF list_item=2 THEN
                ! Do item 2
            ELSE
                ! Do item3
            ENDIF
        ELSE
            ! User has select Cancel
        ENDIF

    ENDPROC
    
ENDMODULE