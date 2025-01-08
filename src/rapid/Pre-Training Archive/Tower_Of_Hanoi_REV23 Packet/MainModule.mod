MODULE MainModule
    !    !*****************************************************
    !    !Module Name:   MainModule
    !    !Version:       1.22
    !    !Description:   Main Module
    !    !Date:          2024-08-01
    !    !Author:        @ManicZanic
    !    !*****************************************************
    !    !Change Log:
    !    !2024-08-01:    @ManicZanic - Orignal core structure developed
    !    !2024-08-21:    @ManicZanic - Moved non TOH routines to Main module.
    !    !                           - Added Menu options to all routines.
    !    !                           - Added NCameraLoop to disconnect variables from other modules
    !    !                           - Cleaned up text a bit
    !    !                           - Formatted text
    !    !                           - Added Yoga Pose positions
    !    !                           - Added blank JustDance program
    !    !2024-08-22:    @ManicZanic - Removed unused code
    !    !                           - Removed task specific ToolData
    !    !2024-08-22:    @ManicZanic - Programmed DancingQueen routine.
    !    !                           - Programmed YogaPose routine
    !    !                           - Edited menu names
    !    !2024-08-26:    @ManicZanic - Modified motion alert notification interface.
    !    !                           - Created universal speed selection progam
    !    !                           - Modified Yoga Poses
    !    !2024-08-29:    @ManicZanic - Updated UI to add option for no motion alarm and to edit menus
    !    !*****************************************************

    PERS bool bMenu:=TRUE;
    PERS bool bTopsy:=FALSE;
    PERS bool bTurvey:=TRUE;
    PERS bool CondomMode:=FALSE;
    PERS bool RawDogMode:=TRUE;

    !CURRENT VELOCITY
    VAR speeddata VSpeed:=V300;

    VAR num ERR_TP_DOBREAK;
    !VAR num CurrentIndex:=nMenuOption;
    VAR num nMenuOption;

    VAR btnres answer;

    CONST string LoopMessage{5}:=[" "," ","Enter How Many Times To Loop Dance Program"," ","0=INFINITE"];
    CONST string CautionMessage{5}:=[" "," "," ","Press RUN to continue","Press CANCEL to return to previous menu"];
    CONST string RunCancel{2}:=["RUN","CANCEL"];
    CONST string MenuButtons{5}:=["SET SPEED","MENU","","RUN","CANCEL"];

    PERS tooldata tMain:=[TRUE,[[0.000145392,0,140.499655058],[1,0,-0.000000126,0]],[1,[0,0,75],[1,0,0,0],0,0,0]];

    CONST jointtarget jHomePos:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jStorage:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jDongStoragePos:=[[90,0,0,0,90,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];


    PROC Main()
        SafeModeMenu;
    ENDPROC




    PROC SafeModeMenu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{6}:=[
        ["1","WANNA SEE SOMETHING COOL!!!"],
        ["2","Select a mode and press OK"],
        ["3"," "],
        ["4","Kid Mode"],
        ["5","Big Boy Dont Need No Warning Mode"],
        ["6",""]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Please select an option and press OK",ListOptions\Buttons:=btnOkCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel Main;
            TEST nMenuOption
            CASE 4:
                CondomMode:=TRUE;
                Main_Menu;
            CASE 5:
                CondomMode:=FALSE;
                Main_Menu;

            ENDTEST
        ENDWHILE
        bMenu:=TRUE;
    ENDPROC


    PROC Main_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        VAR num Temp1:=0;
        CONST Listitem ListOptions{18}:=[
            ["1","Set Speed"],
            ["2","Home Position"],
            ["3","Dong Storage Position"],
            ["4","Storage Position"],
            ["5","Camera Man"],
            ["6","Yoga Pose"],
            ["7","Just Dance"],
            ["8","Tower of Hanoi"],
            ["9","Helicopter Helicopter"],
            ["10","Pile Driver"],
            ["11"," "],
            ["12","***DONT LOOK IM NOT CODED YET!!!***"],
            ["13 to be declared in slot 11","Docking"],
            ["14",""],
            ["15"," "],
            ["16"," "],
            ["17"," "],
            ["18"," "]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Please select an option and press OK",ListOptions\Btnarray:=MenuButtons\Icon:=iconInfo);
            IF btnresMainMenu=1 R_Set_SPEEEEEED;
            IF btnresMainMenu=2 RawdogMode:=FALSE;
            IF btnresMainMenu=4 RawdogMode:=TRUE;
            IF btnresMainMenu=5 Main_Menu;


            TEST nMenuOption
            CASE 1:
                R_Set_SPEEEEEED;
                Main_Menu;
            CASE 2:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        MoveAbsJ jHomePos,v150,fine,tool0;
                    ELSEIF answer=2 THEN
                        Main_Menu;
                    ENDIF
                ELSE
                    MoveAbsJ jHomePos,v150,fine,tool0;
                ENDIF
            CASE 3:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        MoveAbsJ jDongStoragePos,v150,fine,tool0;
                    ELSEIF answer=2 THEN
                        Main_Menu;
                    ENDIF
                ELSE
                    MoveAbsJ jDongStoragePos,v150,fine,tool0;
                    Main_Menu;
                ENDIF
            CASE 4:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        MoveAbsJ jStorage,v150,fine,tool0;
                    ELSEIF answer=2 THEN
                        Main_Menu;
                    ENDIF
                ELSE
                    MoveAbsJ jStorage,v150,fine,tool0;
                ENDIF
                Main_Menu;

            CASE 5:
                IF RawDogMode=FALSE THEN
                    R_CameraMan_Menu;
                ELSE
                    NCameraLoop:=2;
                    R_CameraMan;
                ENDIF
            CASE 6:
                IF RawDogMode=FALSE THEN
                    R_YogaPose;
                ELSE
                    MoveAbsJ jCobra,v150,fine,tool0;
                    WaitTime 5;
                    MoveAbsJ jDoggyStyle,v150,fine,tool0;
                    WaitTime 5;
                    MoveAbsJ jCamel,v150,fine,tool0;
                    WaitTime 5;
                    MoveAbsJ jChair,v150,fine,tool0;
                    WaitTime 5;
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
                    
                ENDIF
            CASE 7:
                IF RawDogMode=FALSE THEN
                    R_DancingQueen_Menu;
                ELSE
                    R_DancingQueen;
                ENDIF
            CASE 8:
                IF RawDogMode=FALSE THEN
                    %"R_Tower_Of_Hanoi_Menu"%;
                ELSE
                    %"R_Tower_Of_Hanoi_SolSel"%;
                ENDIF
            CASE 9:
                IF RawDogMode=FALSE THEN
                    R_Helicopter_Menu;
                ELSE
                    nHelicopter:=2;
                    R_Helicopter;
                ENDIF
            CASE 10:
                IF RawDogMode=FALSE THEN
                    R_PileDriver_Menu;
                ELSE
                    R_PileDriver;
                ENDIF
            CASE 11:
                IF RawDogMode=FALSE THEN
                    R_Docking_Menu;
                ELSE
                    R_Docking;
                ENDIF

            CASE 12:
                TPErase;
                TPWrite "***PERVERT***";
                WaitTime 2;
                TPerase;
                RETURN ;
                bMenu:=False;
            ENDTEST
        ENDWHILE
        bMenu:=TRUE;
    ENDPROC

    PROC R_Set_SPEEEEEED()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        VAR num change_speed:=60;

        CONST Listitem ListOptions{7}:=[
        ["","Super Slow"],
        ["","Slow"],
        ["","Normal"],
        ["","Fast"],
        ["","Super Fast"],
        ["","Helicopter"],
        ["","JUST DONT!!!"]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Select Desired Speed",ListOptions\Buttons:=btnOKCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel RETURN;
            TEST nMenuOption
            CASE 1:
                VSpeed:=V150;
                RETURN ;
            CASE 2:
                VSpeed:=V300;
                RETURN ;
            CASE 3:
                VSpeed:=V500;
                RETURN ;
            CASE 4:
                VSpeed:=V1000;
                RETURN ;
            CASE 5:
                VSpeed:=V2500;
                RETURN ;
            CASE 6:
                VSpeed:=V300;
                SpeedRefresh change_speed;
                RETURN ;
            CASE 7:
                VSpeed:=V10;
                RETURN ;
                !SpeedRefresh change_speed;
                bMenu:=False;
            ENDTEST
        ENDWHILE
        bMenu:=True;
    ENDPROC
ENDMODULE