MODULE M_DancingQueen
    !    !*****************************************************
    !    !Module Name:   M_TEMPLATE
    !    !Version:       1.22
    !    !Description:   DancingQueen
    !    !Date:          2024-08-30
    !    !Author:        @ManicZanic
    !    !               
    !    !*****************************************************
    !    !Change Log:
    !    !2024-08-30:    @ManicZanic - Core structure pulled from MainModule
    !    !*****************************************************
    
    VAR num NDanceLoop:=1;
    VAR num NCurrentDanceLoop:=0;
    
    PROC R_DancingQueen_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[["1","Select an option and press OK to run program"],["2","Press CANCEL to return to Main Menu"],[""," "],[""," "],["","SET SPEED"],["","SET LOOP"],["","RUN PROGRAM"]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="RUN DANCING QUEEN",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
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
            CASE 5:
                R_Set_SPEEEEEED;
                R_DancingQueen_Menu;
            CASE 6:
                NDanceLoop:=UINumEntry(\Header:="Set Repeat Counter"\MsgArray:=LoopMessage\Icon:=iconInfo\InitValue:=NDanceLoop\MinValue:=0\MaxValue:=1000);
                R_DancingQueen_Menu;
            CASE 7:
                answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                IF answer=1 THEN
                    NCurrentDanceLoop:=0;
                    R_DancingQueen;
                ELSEIF answer=2 THEN
                    RETURN ;
                ENDIF
                Main_Menu;
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
        IF NDanceLoop=0 OR NDanceLoop>NCurrentDanceLoop THEN
            R_DancingQueen;
        ENDIF
        MoveAbsJ jHomePos\NoEOffs,VSpeed,fine,tool0;
        !Place Code Here
    ENDPROC
    
ENDMODULE