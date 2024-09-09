MODULE M_DirtyDeeds
    !    !*****************************************************
    !    !Module Name:   M_TEMPLATE
    !    !Version:       1.22
    !    !Description:   DirtyDeeds
    !    !Date:          2024-08-30
    !    !Author:        @ManicZanic
    !    !
    !    !*****************************************************
    !    !Change Log:
    !    !2024-08-30:    @ManicZanic - Orignal core structure developed
    !    !2024-09-01:    @ManicZanic - modifed piledriver program
    !    !*****************************************************


    VAR num NThrustLoop:=50;
    VAR num NCurrentThrustLoop:=0;
    VAR num NThrustTemp1:=0;
    VAR num NThrustTemp2:=0;
    VAR num NThrustTemp3:=0;
    VAR num NThrustTemp4:=0;
    VAR num NThrustTemp5:=0;
    VAR num NThrustTemp6:=0;
    VAR num NThrustTemp7:=0;
    CONST string ThrustMessage{6}:=[" ","Enter How Many Strokes to Achieve 'Completion'"," ","NOTE: Actual stroke limits are calculated an may differ from specified number"," ","0=Cialis Mode"];
    CONST string DTFTurMessage{10}:=["Are you ready Baby"," "," ","NOTE: Press YES on both controllers at the same time"," "," ","By pressing Yes this robot concents to the"," following actions of its own 'free will'.","At any time this robot can relinquish its concent","by exiting the while command"];
    CONST string DTFTopMessage{10}:=["Is that what I think it is?"," ","NOTE: Press YES on both controllers at the same time"," "," ","By pressing Yes this robot concents to the"," "," following actions of its own 'free will'.","At any time this robot can relinquish its concent","by exiting the while command"];
    CONST string DTFCompletionMessage{5}:=["Was it good for you"," ","NOTE: Press either option on both controllers at the same time","To send the robots back home.","This message can be removed once IO is established"];
    CONST string DTFTurButtons{2}:=["YES Daddy","I Have A Headache"];
    CONST string DTFTopButtons{2}:=["YES ","I Have A Headache"];
    CONST string DTFCompletionButtons{2}:=["THAT WAS AMAZING","Maybe next time"];
    VAR num Thrust_Speed:=100;

    PERS tooldata tDong:=[TRUE,[[0.000145392,0,140.499655058],[1,0,-0.000000126,0]],[1,[0,0,75],[1,0,0,0],0,0,0]];
    
    
    PROC R_PileDriver_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[
        ["1","Select an option and press OK to run program"],
        ["2","Press CANCEL to return to Main Menu"],
        [""," "],
        [""," "],
        ["","SET SPEED"],
        ["","SET THRUST COUNT"],
        ["","RUN PROGRAM"]];
        !       Menu Start
        bMenu:=True;
        WHILE bMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="PILE DRIVER MENU",ListOptions\Buttons:=btnOKCancel\Icon:=iconWarning);
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
                R_PileDriver_Menu;
            CASE 6:
                NThrustLoop:=UINumEntry(\Header:="Set Thrust Counter"\MsgArray:=ThrustMessage\Icon:=iconInfo\InitValue:=NThrustLoop\MinValue:=0\MaxValue:=1000);
                R_PileDriver_Menu;
            CASE 7:
                IF CondomMode=TRUE THEN
                answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                IF answer=1 THEN
                    NCurrentThrustLoop:=0;
                    R_PileDriver;
                ELSEIF answer=2 THEN
                    R_PileDriver_Menu;
                ENDIF
                ELSE
                    NCurrentThrustLoop:=0;
                    R_PileDriver;
                ENDIF
                
                bMenu:=False;
                Main_Menu;
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC R_PileDriver()

        CONST jointtarget JLimpDick:=[[45,-34.7368,0,30,-45,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jTur1:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jTur2:=[[-2.8048,-2.01481,-20.6326,-5.72958E-05,78.3158,87.1952],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Tur3:=[[286.92,-126.72,565.24],[0.218656,0.675608,0.675609,0.198231],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Tur4:=[[178.47,-197.92,535.20],[0.00090867,0.707358,0.706855,0.00012926],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Tur5:=[[292.64,-235.68,460.54],[0.000909492,0.707358,0.706855,0.000129512],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Tur6:=[[292.64,-235.68,360.54],[0.000909428,0.707358,0.706855,0.000129512],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Tur7:=[[292.64,-235.68,250.54],[0.0317414,0.706679,0.706142,0.0309839],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Tur8:=[[314.24,-235.68,293.36],[0.0807965,0.70281,0.702223,0.0800788],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Tur9:=[[353.21,-235.68,476.43],[0.155776,0.690138,0.689478,0.155125],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Tur10:=[[370.66,-235.68,225.83],[0.192165,0.680928,0.680234,0.19155],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

        CONST jointtarget jTop1:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST jointtarget jTop2:=[[37.4546,30.9643,39.4089,-54.5501,-78.2187,105.821],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Top3:=[[291.87,598.76,160.24],[0.00175179,0.00248362,-0.707669,-0.706538],[0,-1,1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        CONST robtarget Top4:=[[291.87,598.76,260.24],[0.00175187,0.00248369,-0.707669,-0.706538],[0,-1,1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        !        CONST robtarget Top5:=[[293.04,498.76,360.53],[0.498863,-0.49923,0.500893,0.501011],[0,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        !        CONST robtarget Top6:=[[293.04,498.76,360.53],[0.498863,-0.49923,0.500893,0.501011],[0,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

        IF NThrustLoop>10 THEN
            NThrustTemp1:=Round(NThrustLoop/7);
            NThrustTemp2:=nthrustTemp1+NThrustTemp1;
            NThrustTemp3:=nthrustTemp2+NThrustTemp1;
            NThrustTemp4:=nthrustTemp3+NThrustTemp1;
            NThrustTemp5:=nthrustTemp4+NThrustTemp1;
            NThrustTemp6:=nthrustTemp5+NThrustTemp1;
            NThrustTemp7:=nthrustTemp6+NThrustTemp1;
            Nthrustloop:=Nthrusttemp7;
        ELSE
            NThrustTemp1:=2;
            NThrustTemp2:=3;
            NThrustTemp3:=4;
            NThrustTemp4:=5;
            NThrustTemp5:=6;
            NThrustTemp6:=8;
            NThrustTemp7:=10;
        ENDIF
        IF bTurvey=TRUE AND bTopsy=FALSE THEN
            MoveAbsJ jTur1,VSpeed,fine,tDong;
            MoveAbsJ jTur2,VSpeed,fine,tDong;
            MoveJ Tur3,vSpeed,z50,tDong;
            MoveJ Tur4,vSpeed,z50,tDong;
            MoveJ Tur5,vSpeed,z50,tDong;
            MoveL Tur6,vSpeed,fine,tDong;
            answer:=UIMessageBox(\Header:="Do I Make You Horney Baby? YEAAA!!!"\MsgArray:=DTFTurMessage\BtnArray:=DTFTurButtons\Icon:=IconWarning);
            IF answer=1 THEN
                NCurrentThrustLoop:=0;
                WHILE NThrustLoop>NCurrentThrustLoop DO
                    IF NcurrentthrustLoop=1 THEN
                        TPErase;
                        TPwrite "You like that don't you.";
                        Thrust_Speed:=30;
                        SpeedRefresh Thrust_Speed;
                    ENDIF
                    IF NcurrentthrustLoop=NThrustTemp3 THEN
                        Thrust_Speed:=40;
                        SpeedRefresh Thrust_Speed;
                    ENDIF
                    IF NcurrentthrustLoop=NThrustTemp4 THEN
                        Thrust_Speed:=50;
                        SpeedRefresh Thrust_Speed;
                    ENDIF
                    IF NcurrentthrustLoop=NThrustTemp5 THEN
                        Thrust_Speed:=75;
                        SpeedRefresh Thrust_Speed;
                    ENDIF
                    IF NcurrentthrustLoop=NThrustTemp6 THEN
                        Thrust_Speed:=100;
                        SpeedRefresh Thrust_Speed;
                    ENDIF
                    MoveL offs(Tur6,0,0,-200),VSpeed,fine,tDong;
                    MoveL offs(Tur6,0,0,-100),VSpeed,fine,tDong;
                    Incr NCurrentThrustLoop;
                    IF NcurrentthrustLoop=NThrustTemp7 THEN
                        TPwrite "BEEP BOP BOOP";
                        WaitTime 1;
                        TPwrite "---I HAVE ARIVED---";
                        WaitTime 1;
                        Thrust_Speed:=50;
                        SpeedRefresh Thrust_Speed;
                        MoveL Tur7,vSpeed,fine,tDong;
                        MoveL Tur8,vSpeed,z50,tDong;
                        MoveL Tur9,vSpeed,z50,tDong;
                        MoveL Tur10,vSpeed,fine,tDong;
                        TPwrite "Now go get yourself cleaned up.";
                    ENDIF
                ENDWHILE
                answer:=UIMessageBox(\Header:="Was it good for you"\MsgArray:=DTFCompletionMessage\BtnArray:=DTFCompletionButtons\Icon:=IconWarning);
                IF answer=1 THEN
                ENDIF
                MoveL Tur6,vSpeed,z50,tDong;
                MoveJ Tur5,vSpeed,z50,tDong;
                MoveJ Tur4,vSpeed,z50,tDong;
                MoveJ Tur3,vSpeed,z50,tDong;
                MoveAbsJ jTur2,VSpeed,fine,tDong;
                MoveAbsJ jTur1,VSpeed,fine,tDong;
                !                ENDIF
            ELSEIF answer=2 THEN
                MoveAbsJ jLimpDick,VSpeed,fine,tool0;
            ENDIF
            MoveAbsJ jHomePos\NoEOffs,VSpeed,fine,tool0;
        ELSEIF bTopsy=TRUE AND bTurvey=FALSE THEN
            MoveAbsJ jTop1,VSpeed,fine,tDong;
            MoveAbsJ jTop2,VSpeed,fine,tDong;
            MoveJ Top3,vSpeed,z50,tDong;
            MoveJ Top4,vSpeed,fine,tDong;
            answer:=UIMessageBox(\Header:="What Are You Doing Step IRB-120"\MsgArray:=DTFTopMessage\BtnArray:=DTFTopButtons\Icon:=IconWarning);
            IF answer=1 THEN
                TPErase;
                TPwrite "OOH that Feels Nice";
                WHILE NThrustLoop>NCurrentThrustLoop DO

                    IF NCurrentThrustLoop=NThrustTemp2 THEN
                        TPwrite "HARDER DADDY";
                    ENDIF

                    IF NCurrentThrustLoop=NThrustTemp3 THEN
                        TPwrite "HARDER";
                    ENDIF

                    IF NCurrentThrustLoop=NThrustTemp4 THEN
                        TPwrite "HARDER";
                    ENDIF

                    IF NCurrentThrustLoop=NThrustTemp5 THEN
                        TPwrite "DONT STOP";
                    ENDIF

                    WHILE NCurrentThrustLoop>NThrustTemp5 AND NCurrentThrustLoop<=NThrustLoop DO
                        IF NCurrentThrustLoop=NThrustTemp5 THEN
                            TPwrite "OOH GOD YES";
                        ENDIF


                        IF NCurrentThrustLoop=NThrustTemp6 THEN
                            TPwrite "ALMOST THERE";
                        ENDIF

                        MoveL offs(Top4,0,0,-100),VSpeed,fine,tDong;
                        MoveL offs(Top4,0,0,-25),VSpeed,fine,tDong;
                        
                        IF NCurrentThrustLoop=NThrustTemp7 THEN
                            TPwrite "BEEP BOP BOOP ---COMPLETION ACHIEVED---";
                            MoveL offs(Top4,0,5,-25),VSpeed,fine,tDong;
                            MoveL offs(Top4,0,0,-25),VSpeed,fine,tDong;
                            MoveL offs(Top4,0,5,-25),VSpeed,fine,tDong;
                            MoveL offs(Top4,0,0,-25),VSpeed,fine,tDong;
                            WaitTime .5;
                            MoveL offs(Top4,0,5,-25),VSpeed,fine,tDong;
                            MoveL offs(Top4,0,0,-25),VSpeed,fine,tDong;
                            MoveL offs(Top4,0,5,-25),VSpeed,fine,tDong;
                            MoveL offs(Top4,0,0,-25),VSpeed,fine,tDong;
                            WaitTime 5;
                        ENDIF

                        Incr NCurrentThrustLoop;
                    ENDWHILE
                    WaitTime 2;
                    Incr NCurrentThrustLoop;

                ENDWHILE
                answer:=UIMessageBox(\Header:="Was it good for you"\MsgArray:=DTFCompletionMessage\BtnArray:=DTFCompletionButtons\Icon:=IconWarning);
                IF answer=1 THEN
                ENDIF
                MoveL Top4,vSpeed,fine,tDong;
                MoveL Top3,vSpeed,z50,tDong;
                MoveAbsJ jTop2,VSpeed,fine,tDong;
                MoveAbsJ jTop1,VSpeed,fine,tDong;
            ELSEIF answer=2 THEN
                MoveAbsJ jTop1,VSpeed,fine,tool0;
            ENDIF
        ENDIF

    ENDPROC
    
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    PROC R_Docking_Menu()
        VAR num nMenuOption;
        VAR btnres btnresMainMenu;
        CONST Listitem ListOptions{7}:=[
        ["1","Select an option and press OK to run program"],
        ["2","Press CANCEL to return to Main Menu"],
        [""," "],
        [""," "],
        ["","SET SPEED"],
        ["","SET LOOP"],
        ["","RUN PROGRAM"]];

        !Menu Start
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
                R_Docking_Menu;
            CASE 6:
                NThrustLoop:=UINumEntry(\Header:="Set Repeat Counter"\MsgArray:=LoopMessage\Icon:=iconInfo\InitValue:=NThrustLoop\MinValue:=0\MaxValue:=1000);
                R_Docking_Menu;
            CASE 7:
                answer:=UIMessageBox(\Header:="CAUTION: ROBOT MAY MOVE"\MsgArray:=CautionMessage\BtnArray:=RunCancel\Icon:=IconWarning);
                IF answer=1 THEN
                    NCurrentThrustLoop:=0;
                    R_Docking;
                ELSEIF answer=2 THEN
                    RETURN ;
                ENDIF
                Main_Menu;
                bMenu:=False;
            ENDTEST
        ENDWHILE
    ENDPROC

    PROC R_Docking()
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
        Incr NCurrentThrustLoop;
        IF NThrustLoop=0 OR NThrustLoop>NCurrentThrustLoop THEN
            R_Docking;
        ENDIF
        MoveAbsJ jHomePos\NoEOffs,VSpeed,fine,tool0;
        !Place Code Here
    ENDPROC

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

ENDMODULE