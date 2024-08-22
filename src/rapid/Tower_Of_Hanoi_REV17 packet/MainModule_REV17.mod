MODULE MainModule
    !    !*****************************************************
    !    !Module Name:   MainModule
    !    !Version:       1.01
    !    !Description:   Main Module
    !    !Date:          2024-08-01
    !    !Author:        @ManicZanic
    !    !               @ELIICE
    !    !               @Austin
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
    !    !*****************************************************
    RECORD menu_selection
        num list_selection;
        num button_selection;
    ENDRECORD


    PERS bool bServList:=TRUE;
    PERS bool bMenu:=TRUE;

    PERS num NCameraLoop:=1;!CAMERAMAN LOOP SWITCH

    CONST jointtarget jHomePos:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jStorage:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jCameraMan:=[[0,26.3058,-7.32362,0,-18.9822,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget p1:=[[640.50,-100.00,500.00],[0.707107,3.47691E-8,0.707107,-1.5478E-9],[-1,-1,0,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget p2:=[[640.50,-100.00,400.00],[0.707107,7.61395E-9,0.707107,7.08051E-9],[-1,-1,0,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget p3:=[[640.50,100.00,400.00],[0.707107,-7.61395E-9,0.707107,-7.08051E-9],[0,0,-1,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget p4:=[[640.50,100.00,500.00],[0.707107,-3.47691E-8,0.707107,1.5478E-9],[0,0,-1,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];

    PROC Main()
        Main_Menu;
    ENDPROC

    PROC Main_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{16}:=[["","Home"],["","Storage Position"],["","Camera Man"],["","Yoga Pose"],["","Just Dance"],["","Tower of Hanoi"],[""," "],[""," "],[""," "],["","^^UMM EXCUSE ME. MY SLECTABLE PROGRAMS ARE UP THERE^^"],[""," "],[""," "],[""," "],[""," "],[""," "],[""," ***DONT LOOK IM NOT CODED YET!!!***"]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Please select an option and press OK",ListOptions\Buttons:=btnOKCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
                R_Home;
            CASE 2:
                R_Storage;
            CASE 3:
                R_CameraMan_Menu;
            CASE 4:
                R_YogaPose;
            CASE 5:
                R_DancingQueen;
            CASE 6:
                R_Tower_Of_Hanoi_Menu;
            CASE 10:
                RETURN ;
            CASE 16:
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

    PROC R_Home()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select ACKNOWLEDGE button and press OK to run program"],["","Press CANCEL to return to previous menu"],[""," "],[""," "],["","ACKNOWLEDGE"]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="MOVE ROBOT HOME",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
            CASE 2:
            CASE 3:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
            CASE 4:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
                RETURN ;
            CASE 5:
            CASE 6:
            CASE 7:
                MoveAbsJ jHomePos,v500,fine,tGripperTool;
                RETURN ;
                bMenu:=False;
            ENDTEST
        ENDWHILE
        bMenu:=TRUE;
    ENDPROC

    PROC R_Storage()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select ACKNOWLEDGE button and press OK to run program"],["","Press CANCEL to return to previous menu"],[""," "],[""," "],["","ACKNOWLEDGE"]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="MOVE ROBOT TO STORAGE POSITION",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
            CASE 2:
            CASE 3:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
            CASE 4:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
                RETURN ;
            CASE 5:
            CASE 6:
            CASE 7:
                MoveAbsJ jStorage,v500,fine,tGripperTool;
                RETURN ;
                bMenu:=False;
            ENDTEST
        ENDWHILE
        bMenu:=TRUE;
    ENDPROC

    PROC R_CameraMan_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select Acknowledge button and press OK to run program"],["","Press CANCEL to return to previous menu"],[""," "],[""," "],["","Acknowledge"]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="RUN CAMERAMAN PROGRAM",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
            CASE 2:
            CASE 3:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
            CASE 4:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
                RETURN ;
            CASE 5:
            CASE 6:
            CASE 7:
                NCameraLoop:=2;
                R_CameraMan;
                RETURN ;
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC R_CameraMan()
        IF NCameraLoop=2 THEN
            MoveAbsJ jCameraMan,v500,fine,tGripperTool;
            NCameraLoop:=1;
        ENDIF
        MoveL p1,v100,z50,tGripperTool;
        MoveL p2,v100,z50,tGripperTool;
        MoveL p3,v100,z50,tGripperTool;
        MoveL p4,v100,z50,tGripperTool;
        R_CameraMan;
    ENDPROC

    PROC R_YogaPose()
    CONST jointtarget jCobra:=[[-45,-80,10,35,60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jDoggyStyle:=[[0,20,0,55,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!    CONST jointtarget jTadasana:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jCamel:=[[0,50,-100,0,-60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jChair:=[[0,-70,60,0,80,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];


        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{10}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select POSE and press OK to run program"],["","Press CANCEL to return to previous menu"],[""," "],["","Cobra"],["","Doggy Style"],["","Camel"],["","Chair"],[""," "]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="SELECT YOGA POSE",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
            CASE 2:
            CASE 3:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
            CASE 4:
                TPErase;
                TPwrite "Wrong hole...WRONG HOLE!!!!!";
                waittime 5;
                TPErase;
                RETURN ;
            CASE 5:
            CASE 6:
                MoveAbsJ jCobra,v500,fine,tGripperTool;
                RETURN ;
            CASE 7:
                MoveAbsJ jDoggyStyle,v500,fine,tGripperTool;
                RETURN ;
            CASE 8:
                MoveAbsJ jCamel,v500,fine,tGripperTool;
                RETURN ;
            CASE 9:
                MoveAbsJ jChair,v500,fine,tGripperTool;
                RETURN ;
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC R_DancingQueen()
        !Place Code Here
    ENDPROC

ENDMODULE