MODULE Calibration
!*****************************************************
!Module Name: Calibration
!Version:     1.0
!Description: CCD 1 Calibration program
!Date:        2014/5/7
!Author:      Gavin
!*****************************************************
PROC rCCD1Calibration_1()
        VAR string str_i;
        !SockGet:=FALSE;
        MoveJ phome,v100,z5,tGripper;
        tGripper.tframe.trans.x:=0;
        tGripper.tframe.trans.y:=0;
        !position pCCD1Cali is define in the View's center of the CCD1
        pCCD1Cali:=pCCD1;
        MoveL pCCD1Cali,v100,fine,tGrip2;
        !ConfL\Off;
        !rTCPCalib;
        FOR i FROM 1 TO 9 DO
            SockGet:=FALSE;
            n:=trunc((i-1)/3);
            b:=i-n*3;
            MoveJ offs(pCCD1Cali,(n-1)*4,(b-2)*2.2,0),v100,fine,tGrip2;
            WaitTime\InPos,1;
            pActPos:=CRobT(\Tool:=tGrip2\wobj:=wobj0);
            nPOSCCD1{i}:=pActPos.trans;
            CCD1X{i}:=ValToStr(pActPos.trans.x);
            CCD1y{i}:=ValToStr(pActPos.trans.y);
            str_i:=ValToStr(i);
            !SocketSend socket1 \Str:="ok"+str_i+","+CCD1X{i}+","+CCD1y{i};
            SendStr:="ok,"+str_i+","+CCD1X{i}+","+CCD1y{i};
            WaitUntil SendStr="";
            SocketStr:="";
            SockGet:=TRUE;
            IF i<>9 THEN
                WaitUntil SocketStr="ok,ccd1";
            ENDIF
            WaitTime 1;
        ENDFOR
        WaitUntil SendStr="";
        SockGet:=TRUE;
        SocketStr:="";
        MoveJ phome,v100,z5,tGripper;
    ENDPROC
    
    PROC rToolcheck()
        VAR num tx;
        VAR num ty;
        SockGet:=FALSE;
        !pCCD1Cali:=pCCD1;
        MoveL pHome,v1000,fine,tGripper;
        MoveL pPickWait,v1000,z200,tGripper;
        MoveL offs(pPick,0,0,5),v400,z10,tGripper;
        MoveL pPick,v20,fine,tGripper;
        SendStr:="ok,calibtool5";
        SocketStr:="";
        WaitUntil SendStr="";
        SockGet:=TRUE;
        WaitUntil SocketStr="ok,calibtool5";
        MoveL offs(pPick,0,0,20),v400,z100,tGripper;
        MoveL offs(pCCD1,0,0,20),v400,z100,tGripper;
        MoveL pCCD1,v400,fine,tGripper;
        SockGet:=FALSE;
        WaitTime 1;
        SendStr:="ok,calibtool5";
        SocketStr:="";
        WaitUntil SendStr="";
        SockGet:=TRUE;
        WaitTime 1;
        WaitUntil SocketStr<>"";
        nStrlength:=StrLen(SocketStr);
        nfind:=0;
        FOR i FROM 1 TO 2 DO
            nfind:=StrFind(SocketStr,nFind+1,",");
            nArray1{i}:=nFind;
        ENDFOR
        sCCD:=StrPart(SocketStr,1,nArray1{1}-1);
        ok:=StrToVal(StrPart(SocketStr,nArray1{1}+1,nArray1{2}-nArray1{1}-1),tx);
        ok:=StrToVal(StrPart(SocketStr,nArray1{2}+1,nStrLength-nArray{2}-1),ty);
        rCalibTool1 tx,ty;
        pActPos:=CRobT(\Tool:=tCurtool\wobj:=wobj0);
        SockGet:=FALSE;
        MoveL RelTool(pActPos,0,0,0\Rz:=180),v100,fine,tCurTool;
        SendStr:="ok,180,"+ValToStr(pActPos.trans.X)+","+ValToStr(pActPos.trans.Y);
        SocketStr:="";
        WaitUntil SendStr="";
        SockGet:=TRUE;
        WaitTime 1;
        WaitUntil SocketStr="ok,rot180";
        MoveL pHome,v1000,fine,tGripper;
        SockGet:=FALSE;
        MoveL offs(pPick,0,0,5),v400,z10,tGripper;
        SendStr:="ok,calibtool5";
        SocketStr:="";
        WaitUntil SendStr="";
        SockGet:=TRUE;
        WaitTime 1;
        WaitUntil SocketStr="ok,calibtool5";
        MoveJ pHome,v100,fine,tGripper;
    ENDPROC
   !rTCPCalib:Calibration the TCP through the roution by the CCD data.
    PROC rTCPCalib1()
        VAR num TCP_X;
        VAR num TCP_y;
        VAR string x;
        VAR string y;
        VAR pos pos1;
        pTCPCalib:=RelTool(pCCD1Cali,-2,-2,0);
        SockGet:=FALSE;
        MoveJ RelTool(pTCPCalib,0,0,0),v100,fine,tGripper;
        WaitTime 0.5;
        SendStr:="ok,1,0,0";
        WaitUntil SendStr="";
        SocketStr:="";
        SockGet:=TRUE;
        WaitUntil SocketStr="ok,calibtool";
        MoveL RelTool(pTCPCalib,4,0,0),v100,fine,tGripper;
        WaitTime 0.5;
        SockGet:=FALSE;
        SendStr:="ok,2,4,0";
        WaitUntil SendStr="";
        SocketStr:="";
        SockGet:=TRUE;
        WaitUntil SocketStr="ok,calibtool";
        MoveL pTCPCalib,v100,fine,tGripper;
        SockGet:=FALSE;
        MoveL RelTool(pTCPCalib,0,4,0),v100,fine,tGripper;
        WaitTime 0.5;
        SendStr:="ok,3,0,4";
        WaitUntil SendStr="";
        SocketStr:="";
        SockGet:=TRUE;
        WaitUntil SocketStr="ok,calibtool";
        MoveL pTCPCalib,v100,fine,tGripper;
        SockGet:=FALSE;
        !ConfL\Off;
        MoveJ RelTool(pTCPCalib,0,0,0\Rz:=180),v100,fine,tGripper;
        WaitTime 0.5;
        SendStr:="ok,180d";
        WaitUntil SendStr="";
        SocketStr:="";
        SockGet:=TRUE;
        MoveJ pTCPCalib,v100,fine,tGripper;
        WaitUntil SocketStr<>"";
        nStrlength:=StrLen(SocketStr);
        nfind:=0;
        FOR i FROM 1 TO 2 DO
            nfind:=StrFind(SocketStr,nFind+1,",");
            nArray1{i}:=nFind;
        ENDFOR
        sCCD:=StrPart(SocketStr,1,nArray1{1}-1);
        ok:=StrToVal(StrPart(SocketStr,nArray1{1}+1,nArray1{2}-nArray1{1}-1),TCP_X);
        ok:=StrToVal(StrPart(SocketStr,nArray1{2}+1,nStrLength-nArray1{2}-1),TCP_Y);
        pos1.x:=-TCP_X/2;
        pos1.Y:=-TCP_Y/2;
        pos1.Z:=0;
        tGrip2:=tGripper;
        tGrip2.tframe.trans:=PoseVect(tGripper.tframe,Pos1);
    ENDPROC

  PROC rCalibTool1(var num x,var num y)
    VAR pose poseCCD1;
    VAR pose poseTool;
    VAR num anglex;
    VAR num angley;
    VAR num anglez;
    !MoveJ pCCD1, v500, fine, tGripper;
    !SocketGet sCCD1;
    !data from camera 1
    !CCD1_X: the X value of the feature point in the world coordinate
    posRel.trans.x := X;
    posRel.trans.y := Y;
    !posRel.trans.z := 108;
    posRel.trans.z := pCCD1.trans.z;
    posRel.rot:=pCCD1.rot;
   
   !poseCCD1: pose where to take picture
    poseCCD1.trans:=pCCD1.trans;
    poseCCD1.rot:=pCCD1.rot;
    tCurTool := tGripper;
    !calculate the actual tool data
    poseTool:=PoseMult(PoseInv(poseCCD1),posRel);
    poseTool:=PoseMult(tGripper.tframe,poseTool);
    tCurtool.tframe.trans:=poseTool.trans;
    tCurtool.tframe.rot:=tGripper.tframe.rot;
  ENDPROC
    
    
ENDMODULE