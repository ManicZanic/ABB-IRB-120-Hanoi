MODULE M_Tower_Of_Hanoi
    !    !*****************************************************
    !    !Module Name:   M_Tower_Of_Hanoi
    !    !Version:       1.01
    !    !Description:   Robot program to solve Tower of Haanoi
    !    !Date:          2024-08-01
    !    !Author:        @ManicZanic
    !    !               @ELIICE
    !    !*****************************************************
    !    !Change Log:
    !    !2024-08-01:    @ManicZanic - Orignal core structure developed
    !    !2024-08-01:    @ELIICE - Added to RobotStudio station and updated to function with graphics and added notes.
    !    !                       - Added additional variables for Movements.
    !    !                       - Added Initialize routine to automaticly reset working data variables.
    !    !                       - Reduced solution to the least number of Moves.
    !    !                       - Added General gripper IO signals. Control and state feedback.
    !    !2024-08-04:    @ManicZanic - Generated russan nesting doll style program to handle NOD values up to 10 discs.
    !    !                           - Added step count variables.
    !    !                           - Moved NOD selection to R_Shaft_Stroke_Test routine for easier counter selection.
    !    !2024-08-14:    @Austin - Added basic recursive solution to ToH problem (R_Recursive_Tower_Solution)
    !    !2024-08-21:    @ManicZanic - Added Menu options
    !    !                           - Moved non TOH routines to Main module.
    !    !                           - Reintegrated Recursive Solution into TOH module.
    !    !                           - Upgraded the speed selection menu
    !    !                           - Fromatted text
    !    !2024-08-22:    @ManicZanic - Removed unused code
    !    !                           - Added bTOHmenu bool data
    !    !*****************************************************

    PERS tooldata tGripperTool:=[TRUE,[[0.000145392,0,140.499655058],[1,0,-0.000000126,0]],[1,[0,0,75],[1,0,0,0],0,0,0]];
    TASK PERS wobjdata wobjTower:=[FALSE,TRUE,"",[[0,600,150],[0.707106781,0,0,0.707106781]],[[0,0,0],[1,0,0,0]]];
    TASK PERS wobjdata wobjTower1:=[FALSE,TRUE,"",[[600,0,150],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
    PERS bool bTOHMenu:=TRUE;
	
    !TOWER OF HANOI VARIABLES
    PERS num NDH:=6.35;!NOMINAL DISK HEIGHT
    PERS num NDD:=40;!NOMINAL DISK DIAMETER
    PERS num NSL:=65;!NOMINAL SHAFT LENGTH
    PERS num GOFz:=25;!GripperOffset
    PERS num GSafe:=75;!GripperSafeHeight
    PERS num NOD:=3;!NUMBER OF STACKED DISCS
    PERS num NStart:=1;!START POSITION
    PERS num NEnd:=2;!END POSITION
    PERS num NLoop:=1;!LOOP COUNT
    PERS num NMotionActive:=1;!0 ENABLES ROBOT MoveMENT WHILE 1 DISABLES ROBOT MoveMENT
    PERS num NStepCount:=0;!COMPLETED STEP COUNTER
    PERS num NtenDisc_Count:=26243;!TOTAL NUMBER OF CYCLES TO COMPLETE A 10 DISC TOWER IN STANDARD MODE.
    VAR speeddata VSpeed:=V300;!CURRENT VELOCITY
    PERS num NSpeed:=3;!SPEED SELECTION
    PERS num NJob:=4;!JOB SELECTION
    VAR num NFooBar:=0;!TEMP VAR FOR CALLING FUNC'S

    !WORKING DATA
    PERS num NShaft1X1:=-20;
    PERS num NShaft1Z1:=165;
    PERS num NShaft1Z2:=61.825;
    PERS num NShaft1Z3:=58.65;
    PERS num NShaft1Z4:=-5.95;
    PERS num NShaft2X1:=-20;
    PERS num NShaft2Z1:=165;
    PERS num NShaft2Z2:=61.825;
    PERS num NShaft2Z3:=58.65;
    PERS num NShaft2Z4:=0;
    PERS num NShaft3X1:=-20;
    PERS num NShaft3Z1:=165;
    PERS num NShaft3Z2:=61.825;
    PERS num NShaft3Z3:=58.65;
    PERS num NShaft3Z4:=0;


    CONST robtarget Shaft1:=[[0,200,0],[0.707106781,0,0.707106781,0],[0,0,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Shaft2:=[[0,0,0],[0.707106781,0,0.707106781,0],[0,0,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Shaft3:=[[0,-200,0],[0.707106781,0,0.707106781,0],[-1,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    PROC R_Tower_Of_Hanoi_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["","Run Program"],["","Set Number of Discs"],["","Set Nominal Disc Dimension"],["","Set Nominal Disc Height"],["","Set Nominal Shaft Length"],["","Set Speed"],["","Activate / Deactivate Motion"]];

        bTOHMenu:=True;
        WHILE bTOHMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Tower Of Hanoi MAIN MENU",ListOptions\Buttons:=btnOKCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
                R_Tower_Of_Hanoi;
            CASE 2:
                NOD:=UINumEntry(\Header:="Update Number Of Discs"\Message:="Enter Number Of Stacked Discs"\Icon:=iconInfo\InitValue:=NOD\MinValue:=0\MaxValue:=10);
                R_Tower_Of_Hanoi_Menu;
            CASE 3:
                NDD:=UINumEntry(\Header:="Update Nominal Disc Diameter (Metric)"\Message:="Enter Nominal Disc Diameter (mm) Of Largest Dics In The Stack"\Icon:=iconInfo\InitValue:=NDD\MinValue:=0\MaxValue:=1000);
                R_Tower_Of_Hanoi_Menu;
            CASE 4:
                NDH:=UINumEntry(\Header:="Update Nominal Disc Height (Metric)"\Message:="Enter Nominal Disc Height (mm)"\Icon:=iconInfo\InitValue:=NDH\MinValue:=0\MaxValue:=100);
                R_Tower_Of_Hanoi_Menu;
            CASE 5:
                NSL:=UINumEntry(\Header:="Update Nominal Shaft Length (Metric)"\Message:="Enter Nominal Shaft Length (mm)"\Icon:=iconInfo\InitValue:=NSL\MinValue:=0\MaxValue:=2000);
                R_Tower_Of_Hanoi_Menu;
            CASE 6:
                R_Set_SPEEEEEED;
                R_Tower_Of_Hanoi_Menu;
            CASE 7:
                NMotionActive:=UINumEntry(\Header:="Motion Activation"\Message:="Enter 1 to Enable Motion Enter 0 to Disable Motion"\Icon:=iconInfo\InitValue:=NMotionActive\MinValue:=0\MaxValue:=1);
                R_Tower_Of_Hanoi_Menu;
                bTOHMenu:=False;
            ENDTEST
        ENDWHILE
        bTOHMenu:=True;
    ENDPROC

    PROC R_Set_SPEEEEEED()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        VAR num change_speed:=5;
        CONST Listitem ListOptions{7}:=[["","Super Slow"],["","Slow"],["","Normal"],["","Fast"],["","Super Fast"],[""," "],["","JUST DONT!!!"]];

        bTOHMenu:=True;
        WHILE bTOHMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Select Desired Speed",ListOptions\Buttons:=btnOKCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1:
                VSpeed:=V150;
                R_Tower_Of_Hanoi_Menu;
            CASE 2:
                VSpeed:=V300;
                R_Tower_Of_Hanoi_Menu;
            CASE 3:
                VSpeed:=V500;
                R_Tower_Of_Hanoi_Menu;
            CASE 4:
                VSpeed:=V1000;
                R_Tower_Of_Hanoi_Menu;
            CASE 5:
                VSpeed:=V2500;
                R_Tower_Of_Hanoi_Menu;
            CASE 6:
            CASE 7:
                VSpeed:=V10;
                R_Tower_Of_Hanoi_Menu;
                SpeedRefresh change_speed;
                bTOHMenu:=False;
            ENDTEST
        ENDWHILE
        bTOHMenu:=True;
    ENDPROC

    FUNC num R_Recursive_Tower_Solution(num NCounter,num NFromRod,num NToRod,num NAuxRod)
        !Modeled after https://www.geeksforgeeks.org/c-program-for-tower-of-hanoi/
        IF NCounter=0 THEN
            RETURN 0;
        ENDIF
        NFooBar:=R_Recursive_Tower_Solution(NCounter-1,NFromRod,NAuxRod,NToRod);
        TPWrite "Disk to move: "\Num:=NCounter;
        TPWrite "Source rod: "\Num:=NFromRod;
        TPWrite "Destination Rod: "\Num:=NToRod;
        TPWrite "Moving...";
        NStart:=NFromRod;
        NEnd:=NToRod;
        R_Pick_N_Place;
        TPWrite "Move complete. Onto next move...";
        TPWrite "****************************************";
        NFooBar:=R_Recursive_Tower_Solution(NCounter-1,NAuxRod,NToRod,NFromRod);
        RETURN 0;
    ENDFUNC

    PROC R_Tower_Of_Hanoi()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["","CAUTION: ROBOT MAY MOVE"],[""," "],["","Select solution method and press OK to run program"],["","Press CANCEL to return to previous menu"],[""," "],["","STANDARD"],["","RECURSION"]];

        bTOHMenu:=True;
        WHILE bTOHMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Tower Of Hanoi PROGRAM MENU",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
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
                Initialize;
                R_Shaft_Stroke_Test;
                RETURN ;
            CASE 7:
                Initialize;
                NFooBar:=R_Recursive_Tower_Solution(NOD,1,3,2);
                RETURN ;
                !Moving from rod 1 to rod 3, rod 2 is aux;
                bTOHMenu:=False;
            ENDTEST
        ENDWHILE
        bTOHMenu:=True;
    ENDPROC

    PROC Initialize()
        !Reset Grippers I/O and sequence communication bits

        !SHAFT 1 WORKING DATA

        !Shaft Approach Side.
        NShaft1X1:=-(NDD/2);
        !Shaft Approach Above. Calculate from values to clear the shaft holding disk
        NShaft1Z1:=NSL+GOFz+GSafe;
        !Shaft Drop Position Start
        NShaft1Z2:=NSL-(NDH/2);
        !Shaft Drop Position End
        NShaft1Z3:=NSL-(NDH);
        !Shaft Pick Position. Reset to zero.
        NShaft1Z4:=-0;

        !SHAFT 2 WORKING DATA
        !Shaft Approach Side.
        NShaft2X1:=-(NDD/2);
        !Shaft Approach Above. Calculate from values to clear the shaft holding disk
        NShaft2Z1:=NSL+GOFz+GSafe;
        !Shaft Drop Position Start
        NShaft2Z2:=NSL-(NDH/2);
        !Shaft Drop Position End
        NShaft2Z3:=NSL-(NDH);
        !Shaft Pick Position. Reset to zero.
        NShaft2Z4:=-0;

        !SHAFT 3  WORKING DATA
        !Shaft Approach Side.
        NShaft3X1:=-(NDD/2);
        !Shaft Approach Above. Calculate from values to clear the shaft holding disk
        NShaft3Z1:=NSL+GOFz+GSafe;
        !Shaft Drop Position Start
        NShaft3Z2:=NSL-(NDH/2);
        !Shaft Drop Position End
        NShaft3Z3:=NSL-(NDH);
        !Shaft Pick Position. Reset to zero.
        NShaft3Z4:=-0;

        !Calculate pick height
        !Number of Disks x Nominal Disk Height
        NShaft1Z4:=NOD*NDH-GOFz;
        NShaft2Z4:=(0);
        NShaft3Z4:=(0);

    ENDPROC

    PROC R_Handy()
        !The_Stroke_Handler
        !Modify the following positions to define the locations of each shaft
        MoveL Shaft1,v100,fine,tGripperTool;
        MoveL Shaft2,v100,fine,tGripperTool;
        MoveL Shaft3,v100,fine,tGripperTool;
    ENDPROC

    PROC R_Shaft_Stroke_Test()
        MoveAbsJ jHomePos,v500,fine,tGripperTool;
        NStepCount:=0;!Resets NStepCount to 0
        NLoop:=1;!Resets NLoop to 0
        NOD:=NOD;
        IF NOD=1 THEN
            R_Tier1;
        ENDIF
        IF NOD=2 THEN
            R_Tier2;
        ENDIF
        IF NOD=3 THEN
            R_Tier3;
        ENDIF
        IF NOD=4 THEN
            R_Tier4;
        ENDIF
        IF NOD=5 THEN
            R_Tier5;
        ENDIF
        IF NOD=6 THEN
            R_Tier6;
        ENDIF
        IF NOD=7 THEN
            R_Tier7;
        ENDIF
        IF NOD=8 THEN
            R_Tier8;
        ENDIF
        IF NOD=9 THEN
            R_Tier9;
        ENDIF
        IF NOD=10 THEN
            R_Tier10;
        ENDIF
        MoveAbsJ jHomePos,v500,fine,tool0;
        !Puzzle solved reset values and stop
        !        StopMoveReset\AllMotionTasks;
    ENDPROC

    PROC R_Pick_N_Place()
        IF NMotionActive=1 then
            if NStart=1 then
                MoveJ offs(Shaft1,NShaft1X1,0,NShaft1Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft1,NShaft1X1,0,NShaft1Z4),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft1,0,0,NShaft1Z4),VSpeed,fine,tGripperTool\Wobj:=wobjTower;
                !CLOSE GRIPPER
                !PulseDO \PLength:=1, DO_GripperClose;
                WaitTime 0.2;
                !WaitDI DI_GripperClosed,1 \MaxTime:=0.5;
                MoveL offs(Shaft1,0,0,NShaft1Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                NShaft1Z4:=NShaft1Z4-NDH;
            ENDIF
            if NStart=2 then
                MoveJ offs(Shaft2,NShaft2X1,0,NShaft2Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft2,NShaft2X1,0,NShaft2Z4),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft2,0,0,NShaft2Z4),VSpeed,fine,tGripperTool\Wobj:=wobjTower;
                !CLOSE GRIPPER
                !PulseDO \PLength:=1, DO_GripperClose;
                WaitTime 0.2;
                !WaitDI DI_GripperClosed,1 \MaxTime:=0.5;
                MoveL offs(Shaft2,0,0,NShaft2Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                NShaft2Z4:=NShaft2Z4-NDH;
            ENDIF
            if NStart=3 then
                MoveJ offs(Shaft3,NShaft3X1,0,NShaft3Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft3,NShaft3X1,0,NShaft3Z4),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft3,0,0,NShaft3Z4),VSpeed,fine,tGripperTool\Wobj:=wobjTower;
                !CLOSE GRIPPER
                !PulseDO \PLength:=1, DO_GripperClose;
                WaitTime 0.2;
                !WaitDI DI_GripperClosed,1 \MaxTime:=0.5;
                MoveL offs(Shaft3,0,0,NShaft3Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                NShaft3Z4:=NShaft3Z4-NDH;
            ENDIF
            if NEnd=1 then
                MoveJ offs(Shaft1,0,0,NShaft1Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft1,0,0,NShaft1Z2),VSpeed,fine,tGripperTool\Wobj:=wobjTower;
                !OPEN GRIPPER
                !PulseDO \Plength:=1,DO_GripperClose;
                WaitTime 0.2;
                !WaitDI DI_GripperOpened,1 \MaxTime:=0.5;
                MoveL offs(Shaft1,NShaft1X1,0,NShaft1Z3),VSpeed,z0,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft1,0,0,NShaft1Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                NShaft1Z4:=NShaft1Z4+NDH;
            ENDIF
            if NEnd=2 THEN
                MoveJ offs(Shaft2,0,0,NShaft2Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft2,0,0,NShaft2Z2),VSpeed,fine,tGripperTool\Wobj:=wobjTower;
                !OPEN GRIPPER
                !PulseDO \Plength:=1,DO_GripperClose;
                WaitTime 0.2;
                !WaitDI DI_GripperOpened,1 \MaxTime:=0.5;
                MoveL offs(Shaft2,NShaft2X1,0,NShaft2Z3),VSpeed,z0,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft2,0,0,NShaft2Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                NShaft2Z4:=NShaft2Z4+NDH;
            ENDIF
            IF NEnd=3 THEN
                MoveJ offs(Shaft3,0,0,NShaft3Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft3,0,0,NShaft3Z2),VSpeed,fine,tGripperTool\Wobj:=wobjTower;
                !OPEN GRIPPER
                !PulseDO \Plength:=1,DO_GripperClose;
                WaitTime 0.2;
                !WaitDI DI_GripperOpened,1 \MaxTime:=0.5;
                MoveL offs(Shaft3,NShaft3X1,0,NShaft3Z3),VSpeed,z0,tGripperTool\Wobj:=wobjTower;
                MoveL offs(Shaft3,0,0,NShaft3Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
                NShaft3Z4:=NShaft3Z4+NDH;
            ENDIF
        ENDIF
        incr NStepCount;
    ENDPROC

    PROC R_Tier1()
        IF NOD=1 THEN
            NStart:=1;
            NEnd:=3;
            R_Pick_N_Place;
        ENDIF
        IF NOD>1 THEN
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
        ENDIF
    ENDPROC

    PROC R_Tier2()
        IF NOD>=2 AND NLoop=1 THEN
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            NStart:=1;
            NEnd:=3;
            R_Pick_N_Place;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
        ENDIF
        IF NOD>2 AND NLoop=2 THEN
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            NStart:=3;
            NEnd:=1;
            R_Pick_N_Place;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
        ENDIF
    ENDPROC

    PROC R_Tier3()
        !Move tier 3 to the right tower
        IF NOD>=3 AND NLoop=1 THEN
            R_Tier2;
            NLoop:=2;
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier2;
            NLoop:=1;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
            R_Tier2;
        ENDIF
        !Move tier 3 to the left tower
        IF NOD>3 AND NLoop=2 THEN
            R_Tier2;
            NLoop:=1;
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier2;
            NLoop:=2;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
            R_Tier2;
        ENDIF
    ENDPROC

    PROC R_Tier4()
        !Move tier 4 to the right tower
        IF NOD>=4 AND NLoop=1 THEN
            R_Tier3;
            NLoop:=2;
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier3;
            NLoop:=1;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
            R_Tier3;
        ENDIF
        !Move tier 4 to the left tower
        IF NOD>4 AND NLoop=2 THEN
            R_Tier3;
            NLoop:=1;
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier3;
            NLoop:=2;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
            R_Tier3;
        ENDIF
    ENDPROC

    PROC R_Tier5()
        !Move tier 5 to the right tower
        IF NOD>=5 AND NLoop=1 THEN
            R_Tier4;
            NLoop:=2;
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier4;
            NLoop:=1;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
            R_Tier4;
        ENDIF
        !Move tier 5 to the left tower
        IF NOD>5 AND NLoop=2 THEN
            R_Tier4;
            NLoop:=1;
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier4;
            NLoop:=2;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
            R_Tier4;
        ENDIF
    ENDPROC

    PROC R_Tier6()
        !Move Tier 6 to the right tower
        IF NOD>=6 AND NLoop=1 THEN
            R_Tier5;
            NLoop:=2;
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier5;
            NLoop:=1;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
            R_Tier5;
        ENDIF
        !Move Tier 6 to the left tower
        IF NOD>6 AND NLoop=2 THEN
            R_Tier5;
            NLoop:=1;
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier5;
            NLoop:=2;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
            R_Tier5;
        ENDIF
    ENDPROC

    PROC R_Tier7()
        !Move Tier 7 to the right tower
        IF NOD>=7 AND NLoop=1 THEN
            R_Tier6;
            NLoop:=2;
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier6;
            NLoop:=1;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
            R_Tier6;
        ENDIF
        !Move Tier 7 to the left tower
        IF NOD>7 AND NLoop=2 THEN
            R_Tier6;
            NLoop:=1;
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier6;
            NLoop:=2;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
            R_Tier6;
        ENDIF
    ENDPROC

    PROC R_Tier8()
        !Move Tier 8 to the right tower
        IF NOD>=8 AND NLoop=1 THEN
            R_Tier7;
            NLoop:=2;
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier7;
            NLoop:=1;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
            R_Tier7;
        ENDIF
        !Move Tier 8 to the left tower
        IF NOD>8 AND NLoop=2 THEN
            R_Tier7;
            NLoop:=1;
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier7;
            NLoop:=2;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
            R_Tier7;
        ENDIF
    ENDPROC

    PROC R_Tier9()
        !Move Tier 9 to the right tower
        IF NOD>=9 AND NLoop=1 THEN
            R_Tier8;
            NLoop:=2;
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier8;
            NLoop:=1;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
            R_Tier8;
        ENDIF
        !Move Tier 9 to the left tower
        IF NOD>9 AND NLoop=2 THEN
            R_Tier8;
            NLoop:=1;
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier8;
            NLoop:=2;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
            R_Tier8;
        ENDIF
    ENDPROC

    PROC R_Tier10()
        !Move Tier 10 to the right tower
        IF NOD>=10 AND NLoop=1 THEN
            R_Tier9;
            NLoop:=2;
            NStart:=1;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier9;
            NLoop:=1;
            NStart:=2;
            NEnd:=3;
            R_Pick_N_Place;
            R_Tier9;
        ENDIF
        !Move Tier 10 to the left tower
        IF NOD>10 AND NLoop=2 THEN
            R_Tier9;
            NLoop:=1;
            NStart:=3;
            NEnd:=2;
            R_Pick_N_Place;
            R_Tier9;
            NLoop:=2;
            NStart:=2;
            NEnd:=1;
            R_Pick_N_Place;
            R_Tier9;
        ENDIF

    ENDPROC


ENDMODULE