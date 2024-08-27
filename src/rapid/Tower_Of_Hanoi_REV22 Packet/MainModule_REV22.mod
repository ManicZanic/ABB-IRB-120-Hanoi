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
    !    !*****************************************************

    PERS bool bMenu:=TRUE;
    PERS num NCameraLoop:=1;    !CAMERAMAN LOOP SWITCH
    VAR speeddata VSpeed:=V300;!CURRENT VELOCITY
    VAR num NDanceLoop:=1;
    VAR num NCurrentDanceLoop:=0;
    
    VAR btnres answer; 
    
    CONST string LoopMessage{5}:= [" "," ", "Enter How Many Times To Loop Dance Program"," ","0=INFINITE"]; 
    CONST string CautionMessage{5}:= [" "," ", " ","Press RUN to continue","Press CANCEL to return to previous menu"]; 
    CONST string RunCancel{2}:=["RUN","CANCEL"]; 

    PERS tooldata tMain:=[TRUE,[[0.000145392,0,140.499655058],[1,0,-0.000000126,0]],[1,[0,0,75],[1,0,0,0],0,0,0]];
    
    CONST jointtarget jHomePos:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jStorage:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST jointtarget jCameraMan:=[[0,26.8166,-4.77057,0,-22.0461,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
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
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
            IF answer = 1 THEN 
                MoveAbsJ jHomePos,v500,fine,tool0;
            ELSEIF answer = 2 THEN 
                Main;
            ENDIF
            CASE 2:
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
            IF answer = 1 THEN 
                MoveAbsJ jStorage,v500,fine,tool0;
            ELSEIF answer = 2 THEN 
                Main;
            ENDIF
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

    PROC R_Set_SPEEEEEED()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
!        VAR num change_speed:=5;
        CONST Listitem ListOptions{7}:=[["","Super Slow"],["","Slow"],["","Normal"],["","Fast"],["","Super Fast"],[""," "],["","JUST DONT!!!"]];

        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Select Desired Speed",ListOptions\Buttons:=btnOKCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
                VSpeed:=V150;
                RETURN;
            CASE 2:
                VSpeed:=V300;
                RETURN;
            CASE 3:
                VSpeed:=V500;
                RETURN;
            CASE 4:
                VSpeed:=V1000;
                RETURN;
            CASE 5:
                VSpeed:=V2500;
                RETURN;
            CASE 6:
            CASE 7:
                VSpeed:=V10;
                RETURN;
!                SpeedRefresh change_speed;
                bMenu:=False;
            ENDTEST
        ENDWHILE
        bMenu:=True;
    ENDPROC

    PROC R_CameraMan_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["1","Select an option and press OK to run program"],["2","Press CANCEL to return to Main Menu"],["3"," "],["4"," "],["5","Set Speed"],["6"," "],["7","RUN PROGRAM"]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="RUN CAMERAMAN PROGRAM",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel Main ;
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
                Main ;
            CASE 3:
            CASE 4:
            CASE 5:
                R_Set_SPEEEEEED;
                R_CameraMan_Menu;
            CASE 6:
            CASE 7:
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
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
            MoveAbsJ jCameraMan,v500,fine,tMain;
            NCameraLoop:=1;
        ENDIF
        MoveL p1,v100,z50,tMain;
        MoveL p2,v100,z50,tMain;
        MoveL p3,v100,z50,tMain;
        MoveL p4,v100,z50,tMain;
        R_CameraMan;
    ENDPROC

    PROC R_YogaPose()
        CONST jointtarget jCobra:=[[-45,-80,10,35,60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jDoggyStyle:=[[0,20,60,55,-55,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jCamel:=[[0,50,-100,0,-60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jChair:=[[0,-70,60,0,80,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jStarGazer:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{9}:=[["1","Select an option and press OK to run program"],["2","Press CANCEL to return to Main Menu"],["3"," "],["4","Cobra"],["5","Doggy Style"],["6","Camel"],["7","Chair"],["8","Star Gazer"],["9"," "]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="SELECT YOGA POSE",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel Main;
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
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
            IF answer = 1 THEN 
                MoveAbsJ jCobra,v500,fine,tool0;
            ELSEIF answer = 2 THEN 
                RETURN;
            ENDIF
                R_YogaPose;
            CASE 5:
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
            IF answer = 1 THEN 
                MoveAbsJ jDoggyStyle,v500,fine,tool0;
            ELSEIF answer = 2 THEN 
                RETURN;
            ENDIF
                R_YogaPose;
            CASE 6:
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
            IF answer = 1 THEN 
                MoveAbsJ jCamel,v500,fine,tool0;
            ELSEIF answer = 2 THEN 
                RETURN;
            ENDIF
                R_YogaPose;
            CASE 7:
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
            IF answer = 1 THEN 
                MoveAbsJ jChair,v500,fine,tool0;
            ELSEIF answer = 2 THEN 
                RETURN;
            ENDIF
                R_YogaPose;
            CASE 8:
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
            IF answer = 1 THEN 
                TPErase;
                TPWrite "HEY LOOK A ROCKET SHIP";
                WaitTime 2;
                MoveAbsJ jStarGazer,v500,fine,tool0;
                TPWrite "*      *      *";
                TPWrite "*    *       *    *";
                TPWrite "8=====D~~...___";
                TPWrite "*      *      *";
                TPWrite "*    *       *    *";
                WaitTime 5;
                TPErase;
            ELSEIF answer = 2 THEN 
                RETURN;
            ENDIF
                R_YogaPose;
            CASE 9:
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC R_DancingQueen_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["1","Select an option and press OK to run program"],["2","Press CANCEL to return to Main Menu"],[""," "],[""," "],["","SET SPEED"],["","SET LOOP"],["","RUN PROGRAM"]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="RUN DANCING QUEEN",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel Main ;
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
            CASE 5:
                R_Set_SPEEEEEED;
                R_DancingQueen_Menu;
            CASE 6:
                NDanceLoop:=UINumEntry(\Header:="Set Repeat Counter"\MsgArray:=LoopMessage\Icon:=iconInfo\InitValue:=NDanceLoop\MinValue:=0\MaxValue:=1000);
                R_DancingQueen_Menu;
            CASE 7:
            answer:= UIMessageBox ( \Header:="CAUTION: ROBOT MAY MOVE" \MsgArray:=CautionMessage \BtnArray:=RunCancel \Icon:=IconWarning); 
            IF answer = 1 THEN 
                NCurrentDanceLoop:=0;
                R_DancingQueen;
            ELSEIF answer = 2 THEN 
                RETURN;
            ENDIF
            Main ;
                bMenu:=False;
            ENDTEST
        ENDWHILE
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


        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j2,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j2,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j3,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j3,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j4,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j4,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j5,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j5,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j6,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j6,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j7,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j7,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j8,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j8,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j9,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        MoveAbsJ j9,VSpeed,fine,tool0;
        MoveAbsJ j8,VSpeed,fine,tool0;
        MoveAbsJ j9,VSpeed,fine,tool0;
        MoveAbsJ j8,VSpeed,fine,tool0;
        MoveAbsJ j9,VSpeed,fine,tool0;
        MoveAbsJ j6,VSpeed,fine,tool0;
        MoveAbsJ j7,VSpeed,fine,tool0;
        MoveAbsJ j6,VSpeed,fine,tool0;
        MoveAbsJ j7,VSpeed,fine,tool0;
        MoveAbsJ j6,VSpeed,fine,tool0;
        MoveAbsJ j4,VSpeed,fine,tool0;
        MoveAbsJ j5,VSpeed,fine,tool0;
        MoveAbsJ j4,VSpeed,fine,tool0;
        MoveAbsJ j5,VSpeed,fine,tool0;
        MoveAbsJ j4,VSpeed,fine,tool0;
        MoveAbsJ j2,VSpeed,fine,tool0;
        MoveAbsJ j3,VSpeed,fine,tool0;
        MoveAbsJ j2,VSpeed,fine,tool0;
        MoveAbsJ j3,VSpeed,fine,tool0;
        MoveAbsJ j1,VSpeed,fine,tool0;
        Incr NCurrentDanceLoop;
        IF NDanceLoop=0 OR NDanceLoop > NCurrentDanceLoop THEN
        R_DancingQueen;
        ENDIF
        MoveAbsJ jHomePos\NoEOffs,VSpeed,fine,tool0;
        !Place Code Here
    ENDPROC

ENDMODULE