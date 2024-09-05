MODULE M_Tower_Of_Hanoi
    !    !*****************************************************
    !    !Module Name:   M_Tower_Of_Hanoi
    !    !Version:       1.22
    !    !Description:   Robot program to solve Tower of Haanoi
    !    !Date:          2024-08-01
    !    !Author:        @ManicZanic
    !    !               @ELIICE
    !    !               @Austin
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
    !    !2024-08-23:    @ManicZanic - Commented out parameters to maybe use later
    !    !2024-08-26:    @ManicZanic - Moved Speed to main
    !    !*****************************************************

    RECORD record_shaft_data
        robtarget target;
        num X1;
        num Z1;
        num Z2;
        num Z3;
        num Z4;
    ENDRECORD
    
    PERS tooldata tGripperTool:=[TRUE,[[0.000145392,0,140.499655058],[1,0,-0.000000126,0]],[1,[0,0,75],[1,0,0,0],0,0,0]];
    PERS wobjdata wobjTower:=[FALSE,TRUE,"",[[0,600,150],[0.707106781,0,0,0.707106781]],[[0,0,0],[1,0,0,0]]];
    PERS wobjdata wobjTower1:=[FALSE,TRUE,"",[[600,0,150],[1,0,0,0]],[[0,0,0],[1,0,0,0]]];
	
    !TOWER OF HANOI VARIABLES
    PERS num         disk_height :=  6.35; !NDH
    PERS num       disk_diameter :=    40; !NDD
    PERS num        shaft_length :=    65; !NSL
    PERS num    gripper_offset_z :=    25; !GOFz
    PERS num gripper_safe_height :=    75; !GSafe
    PERS num     number_of_disks :=    10; !NOD
    PERS num           start_pos :=     1; !NStart
    PERS num             end_pos :=     3; !NEnd
    PERS num               NLoop :=     2; !LOOP COUNT
    PERS num          NStepCount :=     27; !COMPLETED STEP COUNTER
    PERS num      NtenDisc_Count := 26243; !TOTAL NUMBER OF CYCLES TO COMPLETE A 10 DISC TOWER IN STANDARD MODE.
    PERS num                NJob :=     4; !JOB SELECTION
    PERS bool      NMotionActive :=  TRUE; !0 ENABLES ROBOT MoveMENT WHILE 1 DISABLES ROBOT MoveMENT
    VAR num              NFooBar :=     0; !TEMP VAR FOR CALLING FUNC'S

    !WORKING DATA

     PERS record_shaft_data shaft_data{3}:=[
        [[[0,200,0],[0.707107,0,0.707107,0],[0,0,-1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]], -20, 165, 61.825, 58.65, -88.5],
        [[[0,0,0],[0.707107,0,0.707107,0],[0,0,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]], -20, 165, 61.825, 58.65, 63.5],
        [[[0,-200,0],[0.707107,0,0.707107,0],[-1,-1,0,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]],-20, 165, 61.825, 58.65, 63.5]
        ];

    PROC R_Tower_Of_Hanoi_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:= [
            ["","Run Program"],
            ["","Set Number of Discs"],
            ["","Set Nominal Disc Dimension"],
            ["","Set Nominal Disc Height"],
            ["","Set Nominal Shaft Length"],
            ["","Set Speed"],
            ["","Activate / Deactivate Motion"]
            ];

        WHILE TRUE DO
            nMenuOption:=UIListView(
                \Result:=btnresMainMenu
                \Header:="Tower Of Hanoi MAIN MENU",
                ListOptions
                \Buttons:=btnOKCancel
                \Icon:=iconInfo);
                
            IF btnresMainMenu=resCancel RETURN;
            TEST nMenuOption
                CASE 1: R_Tower_Of_Hanoi_SolSel;
                CASE 2: number_of_disks:=UINumEntry(\Header:="Update Number Of Discs"\Message:="Enter Number Of Stacked Discs"\Icon:=iconInfo\InitValue:=number_of_disks\MinValue:=0\MaxValue:=10);
                CASE 3: disk_diameter:=UINumEntry(\Header:="Update Nominal Disc Diameter (Metric)"\Message:="Enter Nominal Disc Diameter (mm) Of Largest Dics In The Stack"\Icon:=iconInfo\InitValue:=disk_diameter\MinValue:=0\MaxValue:=1000);
                CASE 4: disk_height:=UINumEntry(\Header:="Update Nominal Disc Height (Metric)"\Message:="Enter Nominal Disc Height (mm)"\Icon:=iconInfo\InitValue:=disk_height\MinValue:=0\MaxValue:=100);
                CASE 5: shaft_length:=UINumEntry(\Header:="Update Nominal Shaft Length (Metric)"\Message:="Enter Nominal Shaft Length (mm)"\Icon:=iconInfo\InitValue:=shaft_length\MinValue:=0\MaxValue:=2000);
                CASE 6: R_Set_SPEEEEEED;
                CASE 7: BoolToggle NMotionActive;
            ENDTEST
        ENDWHILE
    ENDPROC
    
    PROC BoolToggle (INOUT bool value)
        IF value
            THEN value := FALSE;
            ELSE value := TRUE;
        ENDIF
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
        R_Pick_N_Place NFromRod, NToRod;
        TPWrite "Move complete. Onto next move...";
        TPWrite "****************************************";
        NFooBar:=R_Recursive_Tower_Solution(NCounter-1,NAuxRod,NToRod,NFromRod);
        RETURN 0;
    ENDFUNC

    PROC R_Tower_Of_Hanoi_SolSel()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[
            ["","Select solution method and press OK to run program"],
                ["","Press CANCEL to return to previous menu"],
                [""," "],
                [""," "],
                [""," "],
                ["","STANDARD"],
                ["","RECURSION"]
                ];

        WHILE TRUE DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Tower Of Hanoi PROGRAM MENU",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
            IF btnresMainMenu=resCancel return ;
            TEST nMenuOption
            CASE 1: wrong_hole;
            CASE 2: wrong_hole;
            CASE 5: R_Set_SPEEEEEED;
            CASE 6:
                IF ROBOT_MAY_MOVE() THEN 
                    Initialize;
                    R_Tower_Of_Hanoi;
                ENDIF
            CASE 7:
                IF ROBOT_MAY_MOVE() THEN 
                    Initialize;
                    NFooBar:=R_Recursive_Tower_Solution(number_of_disks,1,3,2);!Moving from rod 1 to rod 3, rod 2 is aux;
                ENDIF
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC Initialize()
        !Reset Grippers I/O and sequence communication bits

        FOR i FROM 1 TO Dim(shaft_Data, 1) DO
            !Shaft Approach Side.
            shaft_data{i}.X1 := - (disk_diameter / 2);
            !Shaft Approach Above. Calculate from values to clear the shaft holding disk
            shaft_data{i}.Z1 := shaft_length + gripper_offset_z + gripper_safe_height;
            !Shaft Drop Position Start
            shaft_data{i}.Z2 := shaft_length - (disk_height/2);
            !Shaft Drop Position End
            shaft_data{i}.Z3 := shaft_length - (disk_height);
            !Shaft Pick Position. Reset to zero.
            shaft_data{1}.Z4 := 0;
        ENDFOR

        !Calculate pick height
        !Number of Disks x Nominal Disk Height
        shaft_data{1}.Z4 := number_of_disks * disk_height - gripper_offset_z;
        shaft_data{2}.Z4 := 0;
        shaft_data{3}.Z4 := 0;

    ENDPROC

    PROC R_Handy()
        !The_Stroke_Handler
        !Modify the following positions to define the locations of each shaft
        MoveL shaft_data{1}.target,v100,fine,tGripperTool;
        MoveL shaft_data{2}.target,v100,fine,tGripperTool;
        MoveL shaft_data{3}.target,v100,fine,tGripperTool;
    ENDPROC

    PROC R_Tower_Of_Hanoi()
        Move_Home tGripperTool;
        NStepCount := 0; !Resets NStepCount to 0
        NLoop := 1; !Resets NLoop to 0
        
        R_Tier number_of_disks;

        Move_Home tGripperTool;
        !Puzzle solved reset values and stop
        !StopMoveReset\AllMotionTasks;
    ENDPROC

    PROC R_Pick_N_Place(num start_pos, num end_pos)
        IF NOT NMotionActive THEN
            incr NStepCount;
            RETURN;
        ENDIF
        
        MoveJ offs(shaft_data{start_pos}.target,shaft_data{start_pos}.X1,0,shaft_data{start_pos}.Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
        MoveL offs(shaft_data{start_pos}.target,shaft_data{start_pos}.X1,0,shaft_data{start_pos}.Z4),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
        MoveL offs(shaft_data{start_pos}.target,0,0,shaft_data{start_pos}.Z4),VSpeed,fine,tGripperTool\Wobj:=wobjTower;
        !CLOSE GRIPPER
        !PulseDO \PLength:=1, DO_GripperClose;
        WaitTime 0.2;
        !WaitDI DI_GripperClosed,1 \MaxTime:=0.5;
        MoveL offs(shaft_data{start_pos}.target,0,0,shaft_data{start_pos}.Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
        shaft_data{1}.Z4 := shaft_data{1}.Z4 - disk_height;
        
        MoveJ offs(shaft_data{end_pos}.target,0,0,shaft_data{end_pos}.Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
        MoveL offs(shaft_data{end_pos}.target,0,0,shaft_data{end_pos}.Z2),VSpeed,fine,tGripperTool\Wobj:=wobjTower;
        !OPEN GRIPPER
        !PulseDO \Plength:=1,DO_GripperClose;
        WaitTime 0.2;
        !WaitDI DI_GripperOpened,1 \MaxTime:=0.5;
        MoveL offs(shaft_data{end_pos}.target,shaft_data{end_pos}.X1,0,shaft_data{end_pos}.Z3),VSpeed,z0,tGripperTool\Wobj:=wobjTower;
        MoveL offs(shaft_data{end_pos}.target,0,0,shaft_data{end_pos}.Z1),VSpeed,z5,tGripperTool\Wobj:=wobjTower;
        shaft_data{end_pos}.Z4:=shaft_data{end_pos}.Z4+disk_height;

        incr NStepCount;
    ENDPROC

    PROC R_Tier1()
        IF number_of_disks=1 THEN
            R_Pick_N_Place 1, 3;
        ENDIF
        IF number_of_disks>1 THEN
            R_Pick_N_Place 1, 2;
        ENDIF
    ENDPROC

    PROC R_Tier2()
        IF number_of_disks>=2 AND NLoop=1 THEN
            R_Pick_N_Place 1, 2;
            R_Pick_N_Place 1, 3;
            R_Pick_N_Place 2, 3;
        ENDIF
        IF number_of_disks>2 AND NLoop=2 THEN
            R_Pick_N_Place 3, 2;
            R_Pick_N_Place 3, 1;
            R_Pick_N_Place 2, 1;
        ENDIF
    ENDPROC

    PROC R_Tier(num tier)
        IF tier = 1 THEN 
            R_Tier1;
            RETURN;
        ENDIF
        
        IF tier = 2 THEN 
            R_Tier2;
            RETURN;
        ENDIF
        
        !Move Tier [tier] to the right tower
        IF number_of_disks >= tier AND NLoop=1 THEN
            R_Tier tier-1;
            
            NLoop:=2;
            R_Pick_N_Place 1, 2;
            R_Tier tier-1;
            
            NLoop:=1;
            R_Pick_N_Place 2, 3;
            R_Tier tier-1;
        ENDIF
        
        !Move Tier [tier] to the left tower
        IF number_of_disks > tier AND NLoop=2 THEN
            R_Tier tier-1;
            
            NLoop:=1;
            R_Pick_N_Place 3, 2;
            R_Tier tier-1;
            
            NLoop:=2;
            R_Pick_N_Place 2, 1;
            R_Tier tier-1;
        ENDIF

    ENDPROC

ENDMODULE
