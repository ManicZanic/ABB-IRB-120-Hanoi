MODULE M_Yoga
    !    !*****************************************************
    !    !Module Name:   M_TEMPLATE
    !    !Version:       1.22
    !    !Description:   Yoga
    !    !Date:          2024-08-30
    !    !Author:        @ManicZanic
    !    !
    !    !*****************************************************
    !    !Change Log:
    !    !2024-08-31:    @ManicZanic - Orignal core pulled from MainModule
    !    !*****************************************************
    
        CONST jointtarget jCobra:=[[-45,-80,10,35,60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jDoggyStyle:=[[0,20,60,55,-55,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jCamel:=[[0,50,-100,0,-60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jChair:=[[0,-70,60,0,80,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jStarGazer:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    
    PROC R_YogaPose()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{9}:=[
        ["1","Select an option and press OK to run program"],
        ["2","Press CANCEL to return to Main Menu"],
        ["3"," "],["4","Cobra"],
        ["5","Doggy Style"],
        ["6","Camel"],
        ["7","Chair"],
        ["8","Star Gazer"],
        ["9"," "]];
        
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="SELECT YOGA POSE",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel Main_Menu;
            TEST nMenuOption
            CASE 1:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
            CASE 2:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
                RETURN ;
            CASE 3:
            CASE 4:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        MoveAbsJ jCobra,v150,fine,tool0;
                    ELSEIF answer=2 THEN
                        RETURN ;
                    ENDIF
                ELSE
                    MoveAbsJ jCobra,v150,fine,tool0;
                ENDIF
                R_YogaPose;
            CASE 5:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        MoveAbsJ jDoggyStyle,v150,fine,tool0;
                    ELSEIF answer=2 THEN
                        RETURN ;
                    ENDIF
                ELSE
                    MoveAbsJ jDoggyStyle,v150,fine,tool0;
                ENDIF
                R_YogaPose;
            CASE 6:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        MoveAbsJ jCamel,v150,fine,tool0;
                    ELSEIF answer=2 THEN
                        RETURN ;
                    ENDIF
                ELSE
                    MoveAbsJ jCamel,v150,fine,tool0;
                ENDIF
                R_YogaPose;
            CASE 7:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        MoveAbsJ jChair,v150,fine,tool0;
                    ELSEIF answer=2 THEN
                        RETURN ;
                    ENDIF
                ELSE
                    MoveAbsJ jChair,v150,fine,tool0;
                ENDIF
                R_YogaPose;
            CASE 8:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        MoveAbsJ jStarGazer,v150,fine,tool0;
                    ELSEIF answer=2 THEN
                        RETURN ;
                    ENDIF
                ELSE
                    MoveAbsJ jStarGazer,v150,fine,tool0;
                    TPErase;
                    TPWrite "HEY LOOK A ROCKET SHIP";
                    WaitTime 2;
                    TPWrite "*      *      *";
                    TPWrite "*    *       *    *";
                    TPWrite "   8=====D~~...___";
                    TPWrite "*      *      *";
                    TPWrite "*    *       *    *";
                    WaitTime 5;
                    TPErase;
                    R_YogaPose;
                ENDIF
            CASE 9:
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC
ENDMODULE