MODULE MainModule
    !    !*****************************************************
    !    !Module Name:   MainModule
    !    !Version:       1.19
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
    !    !                           - Edited menu names
    !    !*****************************************************

    PERS bool bMenu:=TRUE;
    PERS num NCameraLoop:=1;    !CAMERAMAN LOOP SWITCH
    VAR speeddata VDanceSpeed:=V300;!CURRENT VELOCITY
    PERS num NDanceSpeed:=3;!SPEED SELECTION
    VAR num NDanceLoop:=1;
    VAR num NCurrentDanceLoop:=0;
    
    VAR btnres answer; 
    CONST string CautionMessage{5}:= [" "," ", " ","Press OK to continue","Press Skip to return to previous menu"]; 
    CONST string RunSkip{2}:=["Run","Skip"]; 

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
        CONST Listitem ListOptions{16}:=[["1","Home"],["2","Storage Position"],["3","Camera Man"],["4","Yoga Pose"],["5","Just Dance"],["6","Tower of Hanoi"],["7"," "],["8"," "],["9"," "],["10","^^UMM EXCUSE ME. MY SLECTABLE PROGRAMS ARE UP THERE^^"],["11"," "],["12"," "],["13"," "],["14"," "],["15"," "],["16"," ***DONT LOOK IM NOT CODED YET!!!***"]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Please select an option and press OK",ListOptions\Buttons:=btnOKCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel Main;
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
                R_DancingQueen_Menu;
            CASE 6:
                R_Tower_Of_Hanoi_Menu;
            CASE 10:
                TPErase;
                TPWrite "HEY LOOK A ROCKET SHIP";
                WaitTime 2;
                TPWrite "8=====D~~...___";
                WaitTime 5;
                TPErase;
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
        CONST Listitem ListOptions{7}:=[["1","CAUTION: ROBOT MAY MOVE"],["2"," "],["3","Select RUN PROGRAM button and press OK to run program"],["4","Press CANCEL to return to previous menu"],["5"," "],["6"," "],["7","RUN PROGRAM"]];
        
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
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunSkip \Icon:=IconWarning); 
            IF answer = 1 THEN 
                MoveAbsJ jHomePos,v500,fine,tool0;
            ELSEIF answer = 2 THEN 
                Main;
            ENDIF
                bMenu:=False;
            ENDTEST
        ENDWHILE
        bMenu:=TRUE;
    ENDPROC

    PROC R_Storage()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select RUN PROGRAM button and press OK to run program"],["","Press CANCEL to return to previous menu"],[""," "],[""," "],["","RUN PROGRAM"]];

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
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunSkip \Icon:=IconWarning); 
            IF answer = 1 THEN 
                MoveAbsJ jStorage,v500,fine,tool0;
                Main;
            ELSEIF answer = 2 THEN 
                Main;
            ENDIF
            bMenu:=False;
            ENDTEST
        ENDWHILE
        bMenu:=TRUE;
    ENDPROC

    PROC R_CameraMan_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select RUN PROGRAM button and press OK to run program"],["","Press CANCEL to return to previous menu"],[""," "],[""," "],["","RUN PROGRAM"]];
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
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunSkip \Icon:=IconWarning); 
            IF answer = 1 THEN 
                NCameraLoop:=2;
                R_CameraMan;
                Main;
            ELSEIF answer = 2 THEN 
                Main;
            ENDIF
                Main;
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC R_CameraMan()
        IF NCameraLoop=2 THEN
            MoveAbsJ jCameraMan,v500,fine,tool0;
            NCameraLoop:=1;
        ENDIF
        MoveL p1,v100,z50,tool0;
        MoveL p2,v100,z50,tool0;
        MoveL p3,v100,z50,tool0;
        MoveL p4,v100,z50,tool0;
        R_CameraMan;
    ENDPROC

    PROC R_YogaPose()
        CONST jointtarget jCobra:=[[-45,-80,10,35,60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jDoggyStyle:=[[0,20,0,55,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!        CONST jointtarget jTadasana:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jCamel:=[[0,50,-100,0,-60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jChair:=[[0,-70,60,0,80,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];


        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{10}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select POSE and press OK to run program"],["","Press CANCEL to return to previous menu"],[""," "],["","Cobra"],["","Doggy Style"],["","Camel"],["","Chair"],[""," "]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="SELECT YOGA POSE",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel Main;
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
                MoveAbsJ jCobra,v500,fine,tool0;
                R_YogaPose;
            CASE 7:
                MoveAbsJ jDoggyStyle,v500,fine,tool0;
                R_YogaPose;
            CASE 8:
                MoveAbsJ jCamel,v500,fine,tool0;
                R_YogaPose;
            CASE 9:
                MoveAbsJ jChair,v500,fine,tool0;
                R_YogaPose;
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC R_DancingQueen_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select an option and press OK"],["","Press CANCEL to return to previous menu"],["","SET LOOP"],["","SET SPEED"],["","RUN PROGRAM"]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="RUN DANCING QUEEN",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel Main ;
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
                NDanceLoop:=UINumEntry(\Header:="Set Repeat Counter"\Message:="Enter How Many Times To Loop Dance Program 0=INFINITE"\Icon:=iconInfo\InitValue:=NDanceLoop\MinValue:=0\MaxValue:=1000);
                R_DancingQueen_Menu;
            CASE 6:
                R_Set_DanceSPEEEEEED;
                R_DancingQueen_Menu;
            CASE 7:
                NCurrentDanceLoop:=0;
                R_DancingQueen;
                Main ;
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC R_Set_DanceSPEEEEEED()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        VAR num change_speed:=100;
        VAR num NDanceLoop:=100;
        VAR num NCurrentDanceLoop:=100;
        CONST Listitem ListOptions{7}:=[["","Super Slow"],["","Slow"],["","Normal"],["","Fast"],["","Super Fast"],[""," "],["","JUST DONT!!!"]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Select Desired Speed",ListOptions\Buttons:=btnOKCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
                VDanceSpeed:=V150;
                R_DancingQueen_Menu;
            CASE 2:
                VDanceSpeed:=V300;
                R_DancingQueen_Menu;
            CASE 3:
                VDanceSpeed:=V500;
                R_DancingQueen_Menu;
            CASE 4:
                VDanceSpeed:=V1000;
                R_DancingQueen_Menu;
            CASE 5:
                VDanceSpeed:=V2500;
                R_DancingQueen_Menu;
            CASE 6:
            CASE 7:
                VDanceSpeed:=V10;
                R_DancingQueen_Menu;
                SpeedRefresh change_speed;
                bMenu:=False;
            ENDTEST
        ENDWHILE
        bMenu:=True;
    ENDPROC
    
    PROC R_DancingQueen()
        CONST jointtarget j1:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j2:=[[45,-34.7368,0,30,-45,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j3:=[[-45,-35,0,-30,-45,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j4:=[[45,-33.512,43.8106,8.56333E-05,-10.2984,-8.82129E-05],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j5:=[[45,29.6234,-17.5512,3.19074E-05,-12.0721,-3.12018E-05],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j6:=[[-45,-33.4907,43.6889,-7.08038E-05,-10.2336,-0.320042],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j7:=[[-45,29.6402,-17.6857,-5.55671E-05,-11.99,-0.320058],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j8:=[[45,19.6394,40.4538,2.45022E-06,-60.0932,-1.22166E-06],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j9:=[[-45,19.6394,40.4538,2.45022E-06,-60.0932,-1.22166E-06],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j10:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j11:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j12:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j13:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j14:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j15:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j16:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j17:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j18:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j19:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget j20:=[[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];


        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j2,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j2,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j3,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j3,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j4,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j4,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j5,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j5,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j6,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j6,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j7,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j7,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j8,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j8,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j9,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        MoveAbsJ j9,VDanceSpeed,fine,tool0;
        MoveAbsJ j8,VDanceSpeed,fine,tool0;
        MoveAbsJ j9,VDanceSpeed,fine,tool0;
        MoveAbsJ j8,VDanceSpeed,fine,tool0;
        MoveAbsJ j9,VDanceSpeed,fine,tool0;
        MoveAbsJ j6,VDanceSpeed,fine,tool0;
        MoveAbsJ j7,VDanceSpeed,fine,tool0;
        MoveAbsJ j6,VDanceSpeed,fine,tool0;
        MoveAbsJ j7,VDanceSpeed,fine,tool0;
        MoveAbsJ j6,VDanceSpeed,fine,tool0;
        MoveAbsJ j4,VDanceSpeed,fine,tool0;
        MoveAbsJ j5,VDanceSpeed,fine,tool0;
        MoveAbsJ j4,VDanceSpeed,fine,tool0;
        MoveAbsJ j5,VDanceSpeed,fine,tool0;
        MoveAbsJ j4,VDanceSpeed,fine,tool0;
        MoveAbsJ j2,VDanceSpeed,fine,tool0;
        MoveAbsJ j3,VDanceSpeed,fine,tool0;
        MoveAbsJ j2,VDanceSpeed,fine,tool0;
        MoveAbsJ j3,VDanceSpeed,fine,tool0;
        MoveAbsJ j1,VDanceSpeed,fine,tool0;
        Incr NCurrentDanceLoop;
        IF NDanceLoop=0 OR NDanceLoop > NCurrentDanceLoop THEN
        R_DancingQueen;
        ENDIF
        MoveAbsJ jHomePos\NoEOffs,VDanceSpeed,fine,tool0;
        !Place Code Here
    ENDPROC

ENDMODULE