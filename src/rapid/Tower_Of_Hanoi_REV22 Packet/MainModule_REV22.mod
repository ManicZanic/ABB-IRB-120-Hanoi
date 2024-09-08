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
    !    !2024-09-05:    @Follansbeast - Added "The_Conductor" dance move
    !    !2024-09-05:    @Follansbeast - Refactored a bunch of code
    !    !                           - Cleaned up menus and removed faulty recursive calls
    !    !                           - Separated 'rocket_ship', 'pervert', 'Move_Home', 'ROBOT_MAY_MOVE', 'wrong_hole', and 'move_to_yoga_pose' into their own procedures to simplify calling
    !    !                           - Cleaned up and strcutured 'R_DancingQueen' using arrays and for loops
    !    !                           - Pushed global variables into relevant functions where possible to reduce scope
    !    !*****************************************************

    PERS tooldata tMain:=[TRUE,[[0.000145392,0,140.499655058],[1,0,-0.000000126,0]],[1,[0,0,75],[1,0,0,0],0,0,0]];
    VAR speeddata VSpeed:=V300;!CURRENT VELOCITY
    
    PROC Main()
        Main_Menu;
    ENDPROC

    PROC Move_Home (PERS tooldata tool)
        CONST jointtarget jHomePos:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        MoveAbsJ jHomePos, V500, fine, tool;
    ENDPROC
    
    PROC Main_Menu()
        CONST jointtarget jStorage:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{16}:=[
            ["1","Home"],
            ["2","Storage Position"],
            ["3","Camera Man"],
            ["4","Yoga Pose"],
            ["5","Just Dance"],
            ["6","Tower of Hanoi"],
            ["7",""],
            ["8"," "],
            ["9"," "],
            ["10","^^UMM EXCUSE ME. MY SLECTABLE PROGRAMS ARE UP THERE^^"],
            ["11"," "],
            ["12"," "],
            ["13"," "],
            ["14"," "],
            ["15"," "],
            ["16"," ***DONT LOOK IM NOT CODED YET!!!***"]
            ];

        WHILE TRUE DO
            nMenuOption:=UIListView(
                \Result:=btnresMainMenu
                \Header:="Please select an option and press OK",
                ListOptions
                \Buttons:=btnOKCancel
                \Icon:=iconInfo
                );
                
            IF btnresMainMenu=resCancel RETURN;
            TEST nMenuOption
                CASE 1: IF ROBOT_MAY_MOVE() Move_Home tool0;
                CASE 2: IF ROBOT_MAY_MOVE() MoveAbsJ jStorage, V500, fine, tool0;
                CASE 3: R_CameraMan_Menu;
                CASE 4: R_YogaPose;
                CASE 5: R_DancingQueen_Menu;
                CASE 6: R_Tower_Of_Hanoi_Menu;
                CASE 10: rocket_ship;
                CASE 16: pervert;
            ENDTEST
        ENDWHILE
        
    ENDPROC
    
    PROC rocket_ship ()
        TPErase;
        TPWrite "HEY LOOK A ROCKET SHIP";
        WaitTime 1;
        TPWrite "8=====D~~...___";
        WaitTime 5;
        TPErase;
    ENDPROC
    
    PROC pervert ()
        TPErase;
        TPWrite "***PERVERT***";
        WaitTime 2;
        TPerase;
    ENDPROC

    FUNC bool ROBOT_MAY_MOVE ()
        VAR btnres answer;
        
        answer:= UIMessageBox (
            \Header:="CAUTION: ROBOT MAY MOVE"
            \MsgArray:=[
                " ",
                " ",
                " ",
                "Press RUN to continue",
                "Press CANCEL to return to previous menu"
                ] 
            \BtnArray:=["RUN","CANCEL"]
            \Icon:=IconWarning
            );
            
        IF answer = 1 RETURN TRUE;
        RETURN FALSE;
    ENDFUNC
    
    PROC R_Set_SPEEEEEED()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
!        VAR num change_speed:=5;
        CONST Listitem ListOptions{7}:=[
            ["","Super Slow"],
            ["","Slow"],
            ["","Normal"],
            ["","Fast"],
            ["","Super Fast"],
            [""," "],
            ["","JUST DONT!!!"]
            ];
            
        WHILE TRUE DO
            nMenuOption:=UIListView(
                \Result:=btnresMainMenu
                \Header:="Select Desired Speed",
                ListOptions
                \Buttons:=btnOKCancel
                \Icon:=iconInfo
                );
                
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1: VSpeed:=V150;
            CASE 2: VSpeed:=V300;
            CASE 3: VSpeed:=V500;
            CASE 4: VSpeed:=V1000;
            CASE 5: VSpeed:=V3000;
            CASE 6:
            CASE 7: VSpeed:=V10;
            ENDTEST
            
            IF NOT nMenuOption = 6 RETURN;
        ENDWHILE
    ENDPROC

    PROC R_CameraMan_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        VAR num NCameraLoop:=1;    !CAMERAMAN LOOP SWITCH
        
        CONST Listitem ListOptions{7}:=[
            ["1","Select an option and press OK to run program"],
            ["2","Press CANCEL to return to Main Menu"],
            ["3"," "],
            ["4"," "],
            ["5","Set Speed"],
            ["6"," "],
            ["7","RUN PROGRAM"]
            ];

        WHILE TRUE DO
            nMenuOption:=UIListView(
                \Result:=btnresMainMenu
                \Header:="RUN CAMERAMAN PROGRAM",
                ListOptions
                \Buttons:=btnOKCancel
                \Icon:=iconWarning
                );
                
            IF btnresMainMenu=resCancel RETURN;
            TEST nMenuOption
                CASE 1: wrong_hole;
                CASE 2: wrong_hole;
                CASE 3:
                CASE 4:
                CASE 5: R_Set_SPEEEEEED;
                CASE 6:
                CASE 7:
                    IF ROBOT_MAY_MOVE() THEN
                        NCameraLoop:=2;
                        R_CameraMan NCameraLoop;
                        RETURN;
                    ENDIF
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC wrong_hole ()
        TPErase;
        TPwrite "Wrong hole...WRONG HOLE!!!!!";
        waittime 5;
        TPErase;
    ENDPROC
    
    PROC R_CameraMan(num NCameraLoop)
        CONST jointtarget jCameraMan:=[[0,26.8166,-4.77057,0,-22.0461,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget p1:=[[640.50,-100.00,500.00],[0.707107,3.47691E-8,0.707107,-1.5478E-9],[-1,-1,0,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
        CONST robtarget p2:=[[640.50,-100.00,400.00],[0.707107,7.61395E-9,0.707107,7.08051E-9],[-1,-1,0,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
        CONST robtarget p3:=[[640.50,100.00,400.00],[0.707107,-7.61395E-9,0.707107,-7.08051E-9],[0,0,-1,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
        CONST robtarget p4:=[[640.50,100.00,500.00],[0.707107,-3.47691E-8,0.707107,1.5478E-9],[0,0,-1,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
        
        IF NCameraLoop=2 THEN
            MoveAbsJ jCameraMan,VSpeed,fine,tMain;
            NCameraLoop:=1;
        ENDIF
        
        MoveL p1,VSpeed,z50,tMain;
        MoveL p2,VSpeed,z50,tMain;
        MoveL p3,VSpeed,z50,tMain;
        MoveL p4,VSpeed,z50,tMain;
        R_CameraMan NCameraLoop;
        ! Not sure what the intent is here, but this needs to be fixed.
        ! This calls itself recursively and each time allocates targets 1-4
        ! If you want this continuous, use WHILE TRUE or similar and avoid self referential calls
    ENDPROC
    
    PROC move_to_yoga_pose (jointtarget target)
        IF ROBOT_MAY_MOVE() MoveAbsJ target,v500,fine,tool0;
    ENDPROC
    
    PROC R_YogaPose()
        CONST jointtarget jCobra:=[[-45,-80,10,35,60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jDoggyStyle:=[[0,20,60,55,-55,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jCamel:=[[0,50,-100,0,-60,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jChair:=[[0,-70,60,0,80,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jStarGazer:=[[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{8}:=[
            ["1","Select an option and press OK to run program"],
            ["2","Press CANCEL to return to Main Menu"],
            ["3"," "],
            ["4","Cobra"],
            ["5","Doggy Style"],
            ["6","Camel"],
            ["7","Chair"],
            ["8","Star Gazer"]
            ];

        WHILE TRUE DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="SELECT YOGA POSE",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel Main;
            TEST nMenuOption
            CASE 1: wrong_hole;
            CASE 2: wrong_hole;
            CASE 3:
            CASE 4: move_to_yoga_pose jCobra;
            CASE 5: move_to_yoga_pose jDoggyStyle;
            CASE 6: move_to_yoga_pose jCamel;
            CASE 7: move_to_yoga_pose jChair;
            CASE 8: 
                IF ROBOT_MAY_MOVE() THEN
                    MoveAbsJ \conc, jStarGazer,v500,fine,tool0;
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
                    WaitRob \ZeroSpeed;
                ENDIF
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC R_DancingQueen_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[
            ["1","Select an option and press OK to run program"],
            ["2","Press CANCEL to return to Main Menu"],
            [""," "],
            ["","SET SPEED"],
            ["","SET LOOP"],
            ["","RUN DANCING QUEEN"],
            ["","CONDUCT THE ORCHESTRA"]
            ];
        VAR num NDanceLoop:=1;
        
        WHILE TRUE DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="RUN DANCING QUEEN",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel Main ;
            TEST nMenuOption
            CASE 1: wrong_hole;
            CASE 2: wrong_hole;
            CASE 3:
            CASE 4: R_Set_SPEEEEEED;
            CASE 5:
                NDanceLoop:=UINumEntry(
                    \Header:="Set Repeat Counter"
                    \MsgArray:=[
                        " ",
                        " ",
                        "Enter How Many Times To Loop Dance Program",
                        " ",
                        "0=INFINITE"
                        ],
                    \Icon:=iconInfo
                    \InitValue:=NDanceLoop
                    \MinValue:=0
                    \MaxValue:=1000);
                    
            CASE 6: IF ROBOT_MAY_MOVE() R_DancingQueen NDanceLoop;
            CASE 7: IF ROBOT_MAY_MOVE() R_The_Conductor NDanceLoop;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC R_DancingQueen(num NDanceLoop)
        CONST jointtarget dance_pose{20}:= [
            [[0,0,-90,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,-34.7368,0,30,-45,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[-45,-35,0,-30,-45,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,-33.512,43.8106,8.56333E-05,-10.2984,-8.82129E-05],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,29.6234,-17.5512,3.19074E-05,-12.0721,-3.12018E-05],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[-45,-33.4907,43.6889,-7.08038E-05,-10.2336,-0.320042],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[-45,29.6402,-17.6857,-5.55671E-05,-11.99,-0.320058],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,19.6394,40.4538,2.45022E-06,-60.0932,-1.22166E-06],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[-45,19.6394,40.4538,2.45022E-06,-60.0932,-1.22166E-06],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],
            [[45,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]
            ];
        VAR num NCurrentDanceLoop := 0;
        VAR num coreography{51} := [
            1,2,1,2,
            1,3,1,3,
            1,4,1,4,
            1,5,1,5,
            1,6,1,6,
            1,7,1,7,
            1,8,1,8,
            1,9,1,9,
            8,9,8,9,
            6,7,6,7,6,
            4,5,4,5,
            4,2,3,2,3,1
            ];
        VAR zonedata fine_no_stop:=[FALSE,0,0,0,0,0,0];

        IF NDanceLoop = 0 THEN
            ! Infinite loop
            WHILE TRUE DO
                FOR j FROM 1 TO Dim(coreography, 1) DO
                    MoveAbsJ dance_pose{coreography{j}},VSpeed,fine,tool0;
                ENDFOR
            ENDWHILE
        ELSE
            FOR i FROM 1 TO NDanceLoop DO
                FOR j FROM 1 TO Dim(coreography, 1) DO
                    MoveAbsJ dance_pose{coreography{j}},VSpeed,fine_no_stop,tool0;
                ENDFOR
            ENDFOR
        ENDIF
        Move_Home tool0;
    ENDPROC

    PROC R_The_Conductor(num NDanceLoop)
        VAR jointtarget dance_pose{20};
        VAR num NCurrentDanceLoop := 0;
        VAR num coreography{14} := [
            1,2,3,4,5,6,7,8,9,10,11,12,13,14
            ];
        VAR zonedata fine_no_stop:=[FALSE,0,0,0,0,0,0];
        
        dance_pose{1}.robax :=  [-30,105, -70, 0, 40,0];
        dance_pose{2}.robax :=  [-35, 90, -57, 0, 30,0];
        dance_pose{3}.robax :=  [-30, 65, -90, 0,  0,0];
        dance_pose{4}.robax :=  [-25, 60,-109, 0,-40,0];
        dance_pose{5}.robax :=  [-20, 90,-109, 0,-30,0];
        dance_pose{6}.robax :=  [ 10,100, -70, 0,  0,0];
        dance_pose{7}.robax :=  [ 30,105, -70, 0, 40,0];
        
        dance_pose{8}.robax :=  [ 30,105,-70, 0, 40,0];
        dance_pose{9}.robax :=  [ 35, 90,-57, 0, 30,0];
        dance_pose{10}.robax := [ 30, 65,-90, 0, 0,0];
        dance_pose{11}.robax := [ 25, 60,-109,0,-40,0];
        dance_pose{12}.robax := [ 20,90,  -109,0,-30,0];
        dance_pose{13}.robax := [-10,100, -70,0,  0,0];
        dance_pose{14}.robax := [-30,105, -70,0, 40,0];
        
        IF NDanceLoop = 0 THEN
            ! Infinite loop
            WHILE TRUE DO
                FOR j FROM 1 TO Dim(coreography, 1) DO
                    MoveAbsJ dance_pose{coreography{j}},VSpeed,z100,tool0;
                ENDFOR
            ENDWHILE
        ELSE
            FOR i FROM 1 TO NDanceLoop DO
                FOR j FROM 1 TO Dim(coreography, 1) DO
                    MoveAbsJ dance_pose{coreography{j}},VSpeed,z100,tool0;
                    !break;
                ENDFOR
            ENDFOR
        ENDIF
        Move_Home tool0;
    ENDPROC
ENDMODULE
