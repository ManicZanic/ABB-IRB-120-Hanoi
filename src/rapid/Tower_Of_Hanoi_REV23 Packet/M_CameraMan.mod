MODULE M_CameraMan
    !    !*****************************************************
    !    !Module Name:   M_TEMPLATE
    !    !Version:       1.22
    !    !Description:   CameraMan
    !    !Date:          2024-08-30
    !    !Author:        @ManicZanic
    !    !
    !    !*****************************************************
    !    !Change Log:
    !    !2024-08-31:    @ManicZanic - Orignal core pulled from MainModule
    !    !*****************************************************
    
    !CAMERAMAN LOOP SWITCH
    PERS num NCameraLoop:=1;
    
    PROC R_CameraMan_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[
        ["1","Select an option and press OK to run program"],
            ["2","Press CANCEL to return to Main Menu"],
            ["3"," "],
            ["4"," "],
            ["5","Set Speed"],
            ["6"," "],
            ["7","RUN PROGRAM"]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="RUN CAMERAMAN PROGRAM",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
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
                Main_Menu;
            CASE 3:
            CASE 4:
            CASE 5:
                R_Set_SPEEEEEED;
                R_CameraMan_Menu;
            CASE 6:
            CASE 7:
                IF CondomMode=TRUE THEN
                    answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                    IF answer=1 THEN
                        NCameraLoop:=2;
                        R_CameraMan;
                        Main_Menu;
                    ELSEIF answer=2 THEN
                        Main_Menu;
                    ENDIF
                ELSE
                    NCameraLoop:=2;
                    R_CameraMan;
                    Main_Menu;
                ENDIF
                Main_Menu;
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC R_CameraMan()
        CONST jointtarget jCameraMan:=[[0,26.8166,-4.77057,0,-22.0461,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget p1:=[[640.50,-10,455.00],[0.707107,3.47691E-8,0.707107,-1.5478E-9],[-1,-1,0,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
        CONST robtarget p2:=[[640.50,-10,440.00],[0.707107,7.61395E-9,0.707107,7.08051E-9],[-1,-1,0,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
        CONST robtarget p3:=[[640.50,5,440.00],[0.707107,-7.61395E-9,0.707107,-7.08051E-9],[0,0,-1,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
        CONST robtarget p4:=[[640.50,5,455.00],[0.707107,-3.47691E-8,0.707107,1.5478E-9],[0,0,-1,1],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];

        IF NCameraLoop=2 THEN
            MoveAbsJ jCameraMan,v500,fine,tMain;
            NCameraLoop:=1;
            setdo SOManButt_on4, 1;
        ENDIF
!        WHILE TRUE DO
        WHILE DOutput(SOManButt_on4)=1 DO
        MoveL p1,vSpeed,z50,tMain;
        MoveL p2,vSpeed,z50,tMain;
        MoveL p3,vSpeed,z50,tMain;
        MoveL p4,vSpeed,z50,tMain;
        ENDWHILE
        RETURN;
    ENDPROC
ENDMODULE