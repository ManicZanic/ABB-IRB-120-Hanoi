MODULE M_Tower_Of_Hanoi
    !*****************************************************
    !Module Name:   M_Tower_Of_Hanoi
    !Version:       1.01
    !Description:   Robot program to solve Tower of Haanoi
    !Date:          2024-08-01
    !Author:        @ManicZanic
    !               @ELIICE
    !*****************************************************
    !Change Log:
    !2024-08-01:    @ManicZanic - Orignal core structure developed
    !2024-08-01:    @ELIICE - Added to RobotStudio station and updated to function with graphics and added notes.
    !                       - Added additional variables for Movements.
    !                       - Added Initialize routine to automaticly reset working data variables.
    !                       - Reduced solution to the least number of Moves.
    !                       - Added General gripper IO signals. Control and state feedback.
    !2024-08-04:    @ManicZanic - Generated russan nesting doll style program to handle NOD values up to 10 discs.
    !                           - Added step count variables.
    !                           - Moved NOD selection to R_Shaft_Stroke_Test routine for easier counter selection.
    !*****************************************************



    PERS tooldata tGripperTool:=[TRUE,[[0.000145392,0,140.499655058],[1,0,-0.000000126,0]],[1,[0,0,75],[1,0,0,0],0,0,0]];
    TASK PERS wobjdata wobjTower:=[FALSE,TRUE,"",[[600,0,50],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];

    PERS num NDH:=50;    !NOMINAL DISK HEIGHT
    PERS num NDD:=150;   !NOMINAL DISK DIAMETER
    PERS num NSL:=200;   !NOMINAL SHAFT LENGTH
    PERS num GOFz:=25;   !GripperOffset
    PERS num GSafe:=75;  !GripperSafeHeight
    PERS num NOD:=5;    !NUMBER OF STACKED DISCS
    PERS num NStart:=2;  !START POSITION
    PERS num NEnd:=3;    !END POSITION
    PERS num NLoop:=1;   !LOOP COUNT
    PERS num NCountActive:=1;       !0 ENABLES ROBOT MoveMENT WHILE 1 DISABLES ROBOT MoveMENT
    PERS num NStepCount:=26243;     !COMPLETED STEP COUNTER
    PERS num NtenDisc_Count:=26243; !TOTAL NUMBER OF CYCLES TO COMPLETE A 10 DISC TOWER.

    !WORKING DATA
    PERS num NShaft1X1:=-75;
    PERS num NShaft1Z1:=300;
    PERS num NShaft1Z2:=175;
    PERS num NShaft1Z3:=150;
    PERS num NShaft1Z4:=175;
    PERS num NShaft2X1:=-75;
    PERS num NShaft2Z1:=300;
    PERS num NShaft2Z2:=175;
    PERS num NShaft2Z3:=150;
    PERS num NShaft2Z4:=0;
    PERS num NShaft3X1:=-75;
    PERS num NShaft3Z1:=300;
    PERS num NShaft3Z2:=175;
    PERS num NShaft3Z3:=150;
    PERS num NShaft3Z4:=0;

    CONST jointtarget jHomePos:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget p1:=[[0,0,0],[0,0,0,0],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Shaft1:=[[0,200,0],[0.707106781,0,0.707106781,0],[0,0,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Shaft2:=[[0,0,0],[0.707106781,0,0.707106781,0],[0,0,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Shaft3:=[[0,-200,0],[0.707106781,0,0.707106781,0],[-1,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    TASK PERS wobjdata TowerWobj:=[FALSE,TRUE,"",[[0,0,0],[1,0,0,0]],[[600,0,50],[1,0,0,0]]];


    PROC main()
        !Run when program pointer is reset to top of main
        Initialize;
        WHILE TRUE DO
            R_Shaft_Stroke_Test;
        ENDWHILE
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
        NOD:=5;!Set number of discs at start
        NCountActive:=1;!Set to 1 to disable motion. Set to 0 to resume motion.
        NStepCount:=0;!Resets NStepCount to 0
        NLoop:=1;!Resets NLoop to 0
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
        StopMoveReset\AllMotionTasks;
    ENDPROC

    PROC R_Pick_N_Place()
    IF NCountActive=0 then
        if NStart=1 then
            MoveJ offs(Shaft1,NShaft1X1,0,NShaft1Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft1,NShaft1X1,0,NShaft1Z4),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft1,0,0,NShaft1Z4),v500,fine,tGripperTool\Wobj:=wobjTower;
            !CLOSE GRIPPER
            !        PulseDO \PLength:=1, DO_GripperClose;
            WaitTime 0.2;
            !WaitDI DI_GripperClosed,1 \MaxTime:=0.5;
            MoveL offs(Shaft1,0,0,NShaft1Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            NShaft1Z4:=NShaft1Z4-NDH;
        ENDIF
        if NStart=2 then
            MoveJ offs(Shaft2,NShaft2X1,0,NShaft2Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft2,NShaft2X1,0,NShaft2Z4),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft2,0,0,NShaft2Z4),v500,fine,tGripperTool\Wobj:=wobjTower;
            !CLOSE GRIPPER
            !        PulseDO \PLength:=1, DO_GripperClose;
            WaitTime 0.2;
            !WaitDI DI_GripperClosed,1 \MaxTime:=0.5;
            MoveL offs(Shaft2,0,0,NShaft2Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            NShaft2Z4:=NShaft2Z4-NDH;
        ENDIF
        if NStart=3 then
            MoveJ offs(Shaft3,NShaft3X1,0,NShaft3Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft3,NShaft3X1,0,NShaft3Z4),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft3,0,0,NShaft3Z4),v500,fine,tGripperTool\Wobj:=wobjTower;
            !CLOSE GRIPPER
            !        PulseDO \PLength:=1, DO_GripperClose;
            WaitTime 0.2;
            !WaitDI DI_GripperClosed,1 \MaxTime:=0.5;
            MoveL offs(Shaft3,0,0,NShaft3Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            NShaft3Z4:=NShaft3Z4-NDH;
        ENDIF
        if NEnd=1 then
            MoveJ offs(Shaft1,0,0,NShaft1Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft1,0,0,NShaft1Z2),v500,fine,tGripperTool\Wobj:=wobjTower;
            !OPEN GRIPPER
            !        PulseDO \Plength:=1,DO_GripperClose;
            WaitTime 0.2;
            !WaitDI DI_GripperOpened,1 \MaxTime:=0.5;
            MoveL offs(Shaft1,NShaft1X1,0,NShaft1Z3),v500,z0,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft1,0,0,NShaft1Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            NShaft1Z4:=NShaft1Z4+NDH;
        ENDIF
        if NEnd=2 THEN
            MoveJ offs(Shaft2,0,0,NShaft2Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft2,0,0,NShaft2Z2),v500,fine,tGripperTool\Wobj:=wobjTower;
            !OPEN GRIPPER
            !        PulseDO \Plength:=1,DO_GripperClose;
            WaitTime 0.2;
            !WaitDI DI_GripperOpened,1 \MaxTime:=0.5;
            MoveL offs(Shaft2,NShaft2X1,0,NShaft2Z3),v500,z0,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft2,0,0,NShaft2Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            NShaft2Z4:=NShaft2Z4+NDH;
        ENDIF
        IF NEnd=3 THEN
            MoveJ offs(Shaft3,0,0,NShaft3Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft3,0,0,NShaft3Z2),v500,fine,tGripperTool\Wobj:=wobjTower;
            !OPEN GRIPPER
            !        PulseDO \Plength:=1,DO_GripperClose;
            WaitTime 0.2;
            !WaitDI DI_GripperOpened,1 \MaxTime:=0.5;
            MoveL offs(Shaft3,NShaft3X1,0,NShaft3Z3),v500,z0,tGripperTool\Wobj:=wobjTower;
            MoveL offs(Shaft3,0,0,NShaft3Z1),v500,z5,tGripperTool\Wobj:=wobjTower;
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