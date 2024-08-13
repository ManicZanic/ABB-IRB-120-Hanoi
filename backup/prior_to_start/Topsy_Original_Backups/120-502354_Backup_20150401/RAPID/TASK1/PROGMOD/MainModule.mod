MODULE MainModule
!*****************************************************
!Module Name: MainModule
!Version:     3.3
!Description: MBG pick and assembly process
!Date:        2014/5/10
!Author:      Gavin Zhang
!*****************************************************    
    !????????
	PERS num nHeigh:=2.6; 
    PERS num DframTransZ:=-0.2;
	CONST speeddata vSlow:=[10,5,5,1000];
	CONST robtarget pTemp:=[[36.61,-311.94,82.16],[3.72224E-05,-1,-4.64438E-05,2.60135E-05],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST speeddata vSlowA:=[2,5,5,1000];
    PERS robtarget pTarget; 
    PERS robtarget pAssemblying:=[[36.61,-311.94,82.16],[3.72224E-05,-1,-4.64438E-05,2.60135E-05],[-1,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR num n1{20};
PROC Main()
  VAR num X;
  VAR num Y;
  VAR string str_i;
  VAR pose poseCCD1;
  VAR pose poseTool;
  VAR num anglex;
  VAR num angley;
  VAR num anglez;
  rInitall;
  WHILE TRUE DO
    WHILE SocketStr<>"" DO    
    IF SocketStr = "robottest" THEN
      FOR i FROM 1 TO 100 DO
          SockGet := FALSE;
      	MoveJ pPickWait, v200, z50, tGripper;
      	MoveL pCCD1, v200, fine, tGripper;
        WaitTime 0.5;
      SendStr:="ok";
      SocketStr:="";
      WaitUntil SendStr="";
      waittime 0.5;
      SockGet := TRUE;
      WaitUntil SocketStr = "ok,ccd1check";
      SocketStr:="";
      ENDFOR
      SockGet := TRUE;
    ELSEIF SocketStr = "robottest2" THEN
      FOR i FROM 1 TO 50 DO
          SockGet := FALSE;
        MoveL offs(pCCD1,0,0,20), v200, fine, tGripper;
      	MoveL pCCD1, v200, fine, tGripper;
        MoveL offs(pCCD1,0,0,20), v200, fine, tGripper;
        MoveJ offs(pPass1,0,0,20), v300, z10, tGripper;
         MoveL pPass1, v600, z10, tGripper;
        AccSet 50, 50;
   !MoveJ pInsert,v300,fine,tCurtool\WObj:=AssFrame;
        MoveL pInsert, v300, fine, tCurtool\WObj:=AssFrame;
        rInsert;
        WaitTime 0.5;
        pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0);
        MoveL offs(pActPos,0,0,20), v300, fine, tGripper\WObj:=wobj0;
        MoveL offs(pCCD1,0,0,20), v200, fine, tGripper;
      	MoveL pCCD1, v200, fine, tGripper;
        WaitTime 0.5;
      SendStr:="ok";
      SocketStr:="";
      WaitUntil SendStr="";
      waittime 0.5;
      SockGet := TRUE;
      WaitUntil SocketStr = "ok,ccd1check";
      SocketStr:="";
      ENDFOR
      SockGet := TRUE;
    ELSEIF SocketStr="ccd1check" THEN
      SockGet:=FALSE;
      !pCCD1Cali:=pCCD1;
      MoveJ pCCD1Cali, v100, fine, tGrip2;
      WaitTime\InPos, 1;
      pActPos:=CRobT(\Tool:=tGrip2\wobj:=wobj0);
      SendStr:="ok,"+ValToStr(pActPos.trans.X)+","+ValToStr(pActPos.trans.Y);
      SocketStr:="";
      WaitUntil SendStr=""; 
      SockGet:=TRUE;
      WaitUntil SocketStr="ccd1checkfinish";
      SocketStr:="";
      SockGet:=TRUE;
      SocketStr:="";
      MoveJ pHome,v100,fine,tGripper;
    ELSEIF SocketStr="ccd2check" THEN
      SockGet:=FALSE;
      MoveJ phome,v100,z5,tGripper;  
   !MoveJ offs(pCCD2Cali,0,0,30),v100,z5,tGripper;
    FOR i FROM 1 TO 9 DO
     n:=trunc((i-1)/3);
     b:=i-n*3;
     pccd2Calib_T{i}:= offs(pCCD2Cali,(n-1)*2,(b-2)*2,0);
    ENDFOR 
   FOR i FROM 1 TO 9 DO
     MoveJ offs(pPickInkpad,0,0,140),v300,z5,tGripper;
     MoveL pPickInkpad,v100,fine,tGripper;
     WaitTime 0.5;
     MoveL offs(pPickInkpad,0,0,140),v300,z5,tGripper;
     SockGet:=FALSE;
     MoveL offs(pccd2Calib_T{ARRAY{i}},0,0,30),v300,fine,tGripper;
     MoveL pccd2Calib_T{ARRAY{i}},v100,fine,tGripper;
     WaitTime\InPos, 1;
     pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0);
     nPOSCCD2{i}:=pActPos.trans;
     CCD2X{i}:=ValToStr(pActPos.trans.x);
     CCD2y{i}:=ValToStr(pActPos.trans.y);
     str_i:=ValToStr(i);
     SendStr:="ok,"+str_i+","+CCD2X{i}+","+CCD2y{i};
     WaitUntil SendStr="";
     SocketStr:="";
     SockGet:=TRUE;
     IF i<>9 THEN
       WaitUntil SocketStr="ok,ccd2";
     ENDIF
     WaitTime 1;
     MoveL offs(pccd2Calib_T{ARRAY{i}},0,0,30),v300,fine,tGripper;       
   ENDFOR 
   SocketStr:="";
   SockGet:=TRUE;
   MoveJ phome,v100,z5,tGripper;
    ELSEIF SocketStr="gotomenubnt"THEN
      SockGet:=FALSE;
      rMoveHome;
      MoveL pPickWait,v1000,fine,tGripper;
      MoveL offs(pPick,0,0,30),v400,fine,tGripper;
      MoveL pPick,v100,fine,tGripper;
      SendStr:="ok";
      SocketStr:="";
      WaitUntil SendStr=""; 
      SockGet:=TRUE;
      !MoveL offs(pPick,0,0,30),v400,fine,tGripper;
    ELSEIF SocketStr="gotombccd" THEN
      SockGet:=FALSE;
      MoveL offs(pPick,0,0,30),v50,fine,tGripper;
      !rMoveHome;
      MoveJ pCCD1,v600,fine,tGripper;
      SendStr:="ok";
      WaitTime 0.2;
      SocketStr:="";
      WaitUntil SendStr="";
      SockGet:=TRUE;
    ELSEIF SocketStr="gotogasket" THEN
      SockGet:=FALSE;
      rMoveHome;
      MoveJ pPass1,v600,z10,tCurTool;
      MoveJ pInsert, v300, fine, tCurtool\WObj:=AssFrame;
      !SocketSend socket1 \Str:="gotogasketfinish";
      SendStr:="ok";
      SocketStr:="";
      WaitUntil SendStr="";
      SockGet:=TRUE;  
     ELSEIF SocketStr="gotoinitpos"THEN
      SockGet:=FALSE;
      rMoveHome;
      !MoveJ pPass1,v600,z10,tGripper;
      MoveJ pHome,v600,fine,tGripper;
      SendStr:="ok";
      SocketStr:="";
      WaitUntil SendStr="";
      SockGet:=TRUE;
    ELSEIF SocketStr="error" THEN
      SockGet:=FALSE; 
      rMoveHome;
      SendStr:="ok";
      SocketStr:="";
      WaitUntil SendStr="";
      SockGet:=TRUE;
    ELSEIF SocketStr="startpress" THEN
      SockGet:=FALSE;
      rMoveHome;
      MoveJ pPass1,v600,z10,tGripper;
      rInsert;
      !MoveL pAssembly,vAssembly,fine,tCurtool;
      SendStr:="ok";
      SocketStr:="";
      WaitUntil SendStr="";
      SockGet:=TRUE;  
    ELSEIF SocketStr="calibpress" THEN
      rFCCalibration;
    ELSEIF SocketStr="calibtool" THEN
      rTCPCalib1;
    ELSEIF SocketStr="ccd1calibration" THEN
       rCCD1Calibration_1;
    ELSEIF SocketStr="calibtool5" THEN
       rToolcheck;
    ELSEIF SocketStr="ccd2calibration" THEN
      rCCD2Calibration;
    ELSEIF SocketStr="startwork" THEN
      rWorkFlow;
    ELSEIF StrPart(SocketStr,1,15)="UpdateRobotData" THEN
      tJogbycp;  
    ENDIF
    rCyclecheck;
    ENDWHILE
    WaitTime 0.2;
  ENDWHILE
ENDPROC
PROC rInitall()
   WHILE diSafetydoorOpen=1 DO
     TPErase;
     TPWrite "The Safe_Door is Opened,Please Close it";
     WaitDI diSafetydoorOpen,0;
   ENDWHILE
   StartMove;
   AccSet 5,5;
   rMoveHome; 
   bEmptyDone:=FALSE;
   SockGet:=TRUE;
   SocketStr:="";
   Reset doRobError1;
   Reset doRobError2;
   Reset doRobError3;
   Reset doRobError4;
   Reset doSocketError;
   Set doReady1;
   IDelete iProcessFinish;
   CONNECT iProcessFinish WITH tProcessFinish;
   ISignalDo doProcessFinish, 1, iProcessFinish;
   IDelete iInitall;
   CONNECT iInitall WITH tInitiall;
   ISignalDI diRobReset,1,iInitall;
   IDelete iInitall;
   CONNECT iInitall WITH tInitiall;
   ISignalDI diHomePos,1,iInitall;
   IDelete iSocketError;
   CONNECT iSocketError WITH tSocketerror;
   ISignalDO doSocketError,1,iSocketError;
   IDelete iEmptydone;
   CONNECT iEmptydone WITH tEmptyDone;
   ISignalDI diEmptydone,1,iEmptydone;
   IDelete intDoor;
   CONNECT intDoor WITH tSafetyDoor;
   ISignalDI diSafetyDoorOpen, 1, intDoor;
ENDPROC
!rWorkFlow:the robot normal working flow;

PROC rWorkFlow()
    VAR string str_i;
    !MoveJ pHome,v1000,fine,tGripper;
    WaitUntil SocketStr="startwork";
      SockGet:=FALSE;
      rGotoMB;
      SockGet:=TRUE;
    WaitUntil SocketStr="gotombccd";
      SockGet:=FALSE;
      rGotoMBCCD;
      SockGet:=TRUE;
    WaitUntil SocketStr<>"";
    WaitUntil StrPart(SocketStr,1,10)="workoffset";
    !Stop;
      SockGet:=FALSE;
      rDataOffset;
      SockGet:=TRUE;
    WaitUntil SocketStr<>"";
    WaitUntil StrPart(SocketStr,1,12)="robot_ponits";
    !Stop;
      SockGet:=FALSE;
      rCCD12Offset;
      SockGet:=TRUE;
    WaitUntil SocketStr="gotogasket";
      SockGet:=FALSE;
      rGotoGasket;
      SockGet:=TRUE;
    WaitUntil SocketStr<>"";
    WaitUntil StrPart(SocketStr,1,5)="guide";
      SockGet:=FALSE;
      rCCD3Guide;
      SockGet:=TRUE;
    WaitUntil SocketStr= "startpress";
      SockGet:=FALSE;
      rMBPress;
      !SockGet:=TRUE;
      WaitTime 1;
      !WaitUntil SocketStr= "gotoinitpos";
      !SockGet:=FALSE;
      rGotoHome;
      SockGet:=TRUE;
ENDPROC
PROC rCyclecheck()
   !SocketStr:="";
   WaitTime 0.5;
ENDPROC

PROC rEmptyDone()
   rMoveHome; 
ENDPROC
PROC rMoveHome()
    VelSet 100,500;
    IF bCurPos(pHome,tGripper,10,10,10,wobj0)THEN
      MoveJ pHome,v500,fine,tGripper;
    ENDIF
    IF bCurPos(pPlace,tGripper,10,10,10,wobj0)THEN
      MoveJ pPlace,v500,z10,tGripper;
      MoveJ offs(pPlace,0,0,30),v500,z10,tGripper;
      MoveJ pHome,v500,fine,tGripper;
    ENDIF
    IF bCurPos(pPick,tGripper,10,10,10,wobj0) THEN
      MoveJ offs(pPick,0,0,20), v500, fine, tGripper;
      MoveJ pHome, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pCCD1Cali,tGripper,10,10,10,wobj0) THEN
      MoveJ pCCD1Cali, v500, z10, tGripper;
      MoveJ offs(pCCD1Cali,0,0,30), v500, z10, tGripper;
      MoveJ pHome, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pCCD2Cali,tGripper,10,10,10,wobj0) THEN
      MoveJ Offs(pCCD2Cali,0,0,30), v100, fine, tGripper;
      MoveL Offs(pPass2,0,0,40), v500, z20, tGripper;
      MoveL pHome, v500, fine, tGripper;
    ENDIF
    IF bCurPos(ppass1,tGripper,10,10,10,wobj0) THEN
      MoveJ ppass2, v500, fine, tGripper;
      MoveJ pHome, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pFcCalib,tGripper,10,10,10,wobj0) THEN
      MoveJ offs(pFcCalib,0,0,50), v500, z10, tGripper;
      MoveJ pHome, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pPlace,tGripper,10,10,10,wobj0) THEN
      MoveJ Offs(pPlace,0,0,20), v500, fine, tGripper;
      MoveJ pHome, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pInsert,tCurTool,10,10,10,AssFrame) THEN
      MoveJ pPass1, v500, fine, tGripper;
      MoveJ pPass2, v500, fine, tGripper;
      MoveJ pHome, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pInsert,tool0,10,10,10,wobj0) THEN
      MoveJ pPass1, v500, fine, tGripper;
      MoveJ pPass2, v500, fine, tGripper;
      MoveJ pHome, v500, fine, tGripper;
    ENDIF
    J_Temp:=CJointT();
    IF ABS(J_Temp.robax.rax_1)<2 AND ABS(J_Temp.robax.rax_2)<2 AND ABS(J_Temp.robax.rax_3)<2 AND ABS(J_Temp.robax.rax_4)<2 AND ABS(J_Temp.robax.rax_5)<2 AND ABS(J_Temp.robax.rax_6)<3 THEN
      MoveJ pPass2, v200, z5, tGripper;
      MoveJ pHome, v200, fine, tGripper;
    ENDIF
    IF bCurrentPos(pHome,tGripper)=FALSE THEN
      ! If no known position is found, check if the robot is in a specified 
      ! window and move him to the first position in the program
      pActPos:=CRobT(\Tool:=tGripper\WObj:=wobj0);
      IF (pPick.trans.x<pActPos.trans.x AND pActPos.trans.x<pCCD2Cali.trans.x) AND (pPick.trans.Y<pActPos.trans.Y AND pActPos.trans.Y<0) AND pActPos.trans.z>pAssembly.trans.z THEN
        MoveL offs(pActPos,0,0,60),v300,z20,tGripper;
        MoveJ pPass2, v200, z5, tGripper;
        MoveJ pHome, v200, fine, tGripper;
      ELSE
          TPErase;
          TPWrite "Please switch robot to Manual mode";
          !TPErase;
          Stop;
          MoveJ pHome,v300,z20,tGripper;  
      ENDIF
    ELSE
       !MoveJ pPass2, v300, z20, tGripper\WObj:=wobj0;
       MoveJ pHome,v300,z20,tGripper;
      ENDIF
    MoveJ pHome,v300,fine,tGripper;
ENDPROC
PROC rGotoHome()
   !MoveL Offs(pAssembly,0,0,30),vAssembly,z10,tCurtool;
   pActPos:=CRobT(\Tool:=tCurTool\WObj:=AssFrame1);
   MoveL Offs(pActPos,0,0,5), v5, z1, tCurTool\WObj:=AssFrame1;
   MoveL Offs(pActPos,0,0,10), v50, z1, tCurTool\WObj:=AssFrame1;
   ConfL\On;
   AccSet 100, 100;
   MoveJ pPass2, v1000, z10, tGripper;
   MoveJ pHome, v1000, fine, tGripper;
   !SocketSend socket1 \Str:="gotoinitposfinish";
   SendStr:="gotoinitposfinish";
   SocketStr:="";
   WaitUntil SendStr="";
ENDPROC


PROC rMBPress()
   ConfL\Off;
   AssFrame1.uframe.trans:=AssFrame.uframe.trans;
   AssFrame1.uframe.rot:=AssFrame.uframe.rot * OrientZYX(90,0,0);
    AccSet 5, 5;
   MoveL RelTool(Offs(pAssembly,noffsy,noffsx,nHeigh),0,0,0\Rx:=0\Ry:=0\Rz:=0), vSlow, fine, tCurtool\WObj:=AssFrame1;
   MoveL RelTool(Offs(pAssembly,noffsY,noffsX,0),0,0,0\Rx:=0\Ry:=0\Rz:=0), vSlowA, fine, tCurtool\WObj:=AssFrame1;
   WaitTime 1;
   SendStr:="pressfinish";
   SocketStr:="";
   WaitUntil SendStr="";
ENDPROC
PROC rMBPress1()
   ConfL\Off;
   AssFrame1.uframe.trans:=AssFrame.uframe.trans;
   AssFrame1.uframe.rot:=AssFrame.uframe.rot * OrientZYX(90,0,0);
   pAssembly.trans.z:=pCCD2Cali.trans.z-26;
    AccSet 5, 5;
   pTarget:=RelTool(Offs(pAssembly,noffsy,noffsx,0),0,0,-0.50\Rx:=0\Ry:=0\Rz:=0);
   MoveL RelTool(Offs(pAssembly,noffsy,noffsx,nHeigh),0,0,0\Rx:=0\Ry:=0\Rz:=0), vSlow, fine, tCurtool\WObj:=AssFrame1;
   SearchL\Stop, diFCReach, pAssemblying, pTarget, v5, tCurtool\WObj:=AssFrame1;
   WaitTime 0.5;
   SendStr:="pressfinish";
   SocketStr:="";
   WaitUntil SendStr="";
   ERROR
   IF ERRNO=ERR_WHLSEARCH THEN
	  WaitTime 0.5;
      TPWrite"the FC Sensor is error,need check it";
      SendStr:="pressfinish"; 
      SocketStr:="";
      WaitUntil SendStr="";
   ENDIF
ENDPROC
PROC rCCD3Guide()
   X3:=DataGet(1,1,SocketStr);
   SendStr:="recvguide";
   AccSet 30, 20;
   MoveL Reltool(pInsert,nccd3offsx,0,x3+nccd3offs), v20, z10, tCurTool\WObj:=AssFrame;
   MoveL Offs(RelTool(pInsert,nccd3offsx,1,X3 + nccd3offs),0,0,-40), v50, fine, tCurTool\WObj:=AssFrame;
   rInsert;
   SocketStr:="";
   WaitUntil SendStr=""; 
ENDPROC
PROC rGotoGasket()
   MoveJ offs(pCCD1,0,0,100),v400,z50,tGripper;
   MoveJ offs(pPass1,0,0,20), v300, z10, tGripper;
   MoveL pPass1, v600, z10, tGripper;
   AccSet 20, 20;
   MoveJ pInsert, v200, fine, tCurTool\WObj:=AssFrame;
   IF OpMode()=OP_MAN_PROG Stop;
   WaitTime\InPos, 1.5;
   SendStr:="gotogasketfinish";
   SocketStr:="";
   WaitUntil SendStr="";
ENDPROC
PROC rCCD12Offset()
 X1:=DataGet(1,6,SocketStr);
 Y1:=DataGet(2,6,SocketStr);
 nAngle1:=DataGet(3,6,SocketStr);
 X2:=DataGet(4,6,SocketStr);
 Y2:=DataGet(5,6,SocketStr);
 nAngle2:=DataGet(6,6,SocketStr);
 SendStr:="recvok";
 rCalibTool;
 rDefAssFrame;
 WaitUntil SendStr="";
 SocketStr:="";
ENDPROC

PROC DTEST()
  XC:=DataGet (1,2,socketstr); 
  YC:=DataGet (2,2,socketstr);
  WaitTime 1;
ENDPROC

PROC rDataOffset()
 noffsX:=DataGet(1,6,SocketStr);
 noffsy:=DataGet(2,6,SocketStr);
 noffsAngle:=DataGet(3,6,SocketStr); 
 nAssX:=DataGet(4,6,SocketStr);
 nAssy:=DataGet(5,6,SocketStr);
 nAssz:=DataGet(6,6,SocketStr);
 DframTransZ := nAssz;
 SendStr:="recvworkoffsetmsg";
 WaitUntil SendStr="";
 SocketStr:="";
ENDPROC
PROC rGotoMBCCD()
   MoveJ offs(pCCD1,0,0,20),v400,z100,tGripper;
   MoveL pCCD1,v400,fine,tGripper;
   IF OpMode()=OP_MAN_PROG Stop;
   WaitTime\InPos, 0.5;
   SendStr:="gotombccdfinish";
   SocketStr:="";
   WaitUntil SendStr="";
ENDPROC
PROC rGotoMB()
   MoveL pHome, v1000, fine, tGripper;
   MoveL offs(pPick,0,0,5),v400,z10,tGripper;
   MoveL pPick, v20, fine, tGripper;
   SendStr:="gotomenubntfinish";
   WaitTime 0.5;
   MoveL offs(pPick,0,0,2.5), vSlow, fine, tGripper;
   MoveL offs(pPick,0,0,10),v400,z100,tGripper;
   SocketStr:="";
   WaitUntil SendStr=""; 
ENDPROC
!rInser:the insert action to assembly of the robot
PROC rInsert()
    nPoseAss:=[[nAssy,-nAssx,nAssz],[1,0,0,0]];
    PDispSet nPoseAss;
	MoveL p20, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p30, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p40, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p50, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p60, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p70, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p80, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p90, vAssembly, z1, tCurTool\WObj:=AssFrame;
	PDispOff ;
	RETURN;
	MoveL p100, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p110, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p120, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p130, vAssembly, z1, tCurTool\WObj:=AssFrame;
	MoveL p150, vAssembly, z1, tCurTool\WObj:=AssFrame;
	!Stop;
	MoveL p180, vAssembly, z1, tGripper\WObj:=wobj0;
	MoveL p190, vAssembly, z1, tGripper\WObj:=wobj0;
	MoveL p200, vAssembly, z1, tGripper\WObj:=wobj0;
	MoveL p210, vAssembly, z1, tGripper\WObj:=wobj0;
	MoveL p220, vAssembly, z1, tGripper\WObj:=wobj0;
ENDPROC
PROC tJogbycp()
  nfind := 0;
  nTempX:=0;
  nTempY:=0;
  nTempZ:=0;
  nTAnglez:=0;
  nTAngley:=0;
  nTAnglex:=0;
  nPositionNo:=0;
  nHtemp:=0;
  FOR i FROM 1 TO 2 DO
      nfind := StrFind(SocketStr,nFind+1,",");  
      nArray1{i}:=nFind;
  ENDFOR 
  sFirstStr := StrPart(SocketStr,1,nArray1{1}-1);
  sSecondStr:=StrPart(SocketStr,nArray1{1}+1,nArray1{2}-nArray1{1}-1);
  IF sSecondStr="gotopoint" THEN
     nStrlength := StrLen(SocketStr);
     nFind:=0;
     FOR i FROM 1 TO 3 DO
       nfind := StrFind(SocketStr,nFind+1,",");  
       nArray1{i}:=nFind;
     ENDFOR
     sFirstStr := StrPart(SocketStr,1,nArray1{1}-1);
     sSecondStr := StrPart(SocketStr,nArray1{1}+1,nArray1{2}-nArray1{1}-1);
     ok := StrToVal(StrPart(SocketStr,nArray1{2}+1,nArray1{3}-nArray1{2}-1),nPositionNo);
     ok := StrToVal(StrPart(SocketStr,nArray1{3}+1,nStrLength-nArray1{3}),nHtemp);
     TEST nPositionNo
     CASE 141:
       !141 Gasket Calibration position
       MoveL offs(pCCD2Cali,0,0,nHtemp), v50, fine, tGripper;
       !MoveL pCCD2Cali, v200, fine, tGripper;
     CASE 16:
     !Guide take picture position
       MoveL offs(pInsert,0,0,nHtemp), v50, fine, tCurtool\WObj:=AssFrame;
       !MoveL pInsert, v200, fine, tCurtool\WObj:=AssFrame;
     CASE 142:
     !Gasket calibration pick inkpad position 
       MoveL offs(pPickInkpad,0,0,nHtemp), v50, fine, tGripper;
       !MoveL pPickInkpad, v200, fine, tGripper;
     CASE 350:
     !pick the menu buttun position 
       MoveL offs(pPick,0,0,nHtemp), v50, fine, tGripper;
       !MoveL pPick, v200, fine, tGripper;
     CASE 351:
     !menu buttun calibration position 
       MoveL offs(pCCD1,0,0,nHtemp), v50, fine, tGripper;
       !MoveL pCCD1, v200, fine, tGripper;
     CASE 352:
     !the home position 
       MoveL offs(pHome,0,0,nHtemp), v50, fine, tGripper;
       !MoveL pHome, v200, fine, tGripper;
     ENDTEST
     SockGet:=FALSE;
     rBackVal;
     SockGet:=TRUE;   
  ELSEIF sSecondStr="updatemove" THEN
     nStrlength := StrLen(SocketStr);
     nFind:=0;
     FOR i FROM 1 TO 8 DO
       nfind := StrFind(SocketStr,nFind+1,",");  
       nArray1{i}:=nFind;
     ENDFOR
     sFirstStr := StrPart(SocketStr,1,nArray1{1}-1);
     sSecondStr := StrPart(SocketStr,nArray1{1}+1,nArray1{2}-nArray1{1}-1);
     sFrame := StrPart(SocketStr,nArray1{2}+1,nArray1{3}-nArray1{2}-1);
     ok := StrToVal(StrPart(SocketStr,nArray1{3}+1,nArray1{4}-nArray1{3}-1),nTempX);      
     ok := StrToVal(StrPart(SocketStr,nArray1{4}+1,nArray1{5}-nArray1{4}-1),nTempY);
     ok := StrToVal(StrPart(SocketStr,nArray1{5}+1,nArray1{6}-nArray1{5}-1),nTempZ);
     ok := StrToVal(StrPart(SocketStr,nArray1{6}+1,nArray1{7}-nArray1{6}-1),nTAnglez);
     ok := StrToVal(StrPart(SocketStr,nArray1{7}+1,nArray1{8}-nArray1{7}-1),nTAngley);
     ok := StrToVal(StrPart(SocketStr,nArray1{8}+1,nStrLength-nArray1{8}-1),nTAnglex);
     pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0);
     IF sFrame="tool" THEN
        MoveL RelTool(offs(pActPos,0,0,0),nTempX,nTempY,nTempZ\Rx:=-nTAnglex\Ry:=-nTAngley\Rz:=-nTAnglez), v50, fine, tGripper;
     ELSEIF sFrame="world" THEN
        MoveL RelTool(Offs(pActPos,nTempX,nTempY,nTempZ),0,0,0\Rx:=-nTAnglex\Ry:=-nTAngley\Rz:=-nTAnglez), v50, fine, tGripper;
     ENDIF
     SockGet:=FALSE;
       rBackVal;
     SockGet:=TRUE;   
  ELSEIF sSecondStr="savepoint" THEN
     nStrlength := StrLen(SocketStr);
     nFind:=0;
     FOR i FROM 1 TO 2 DO
       nfind := StrFind(SocketStr,nFind+1,",");  
       nArray1{i}:=nFind;
     ENDFOR
     sFirstStr := StrPart(SocketStr,1,nArray1{1}-1);
     sSecondStr := StrPart(SocketStr,nArray1{1}+1,nArray1{2}-nArray1{1}-1);
     ok := StrToVal(StrPart(SocketStr,nArray1{2}+1,nStrLength-nArray1{2}),nPositionNo);
     TEST nPositionNo
     CASE 141:
       !141 Gasket Calibration position
       pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0); 
       pCCD2Cali:=pActPos;
     CASE 16:
     !Guide take picture position
       pActPos:=CRobT(\Tool:=tCurtool\wobj:=AssFrame);
       pInsert:=pActPos;
     CASE 142:
     !Gasket calibration pick inkpad position 
       pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0); 
       pPickInkpad:=pActPos;
     CASE 350:
     !pick the menu buttun position 
       pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0);
       pPick:=pActPos;
     CASE 351:
     !menu buttun calibration position 
       pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0); 
       pCCD1:=pActPos;
     CASE 352:
     !the home position 
       pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0);
       pHome:=pActPos;
     ENDTEST
     SockGet:=FALSE;
     rBackVal;
     SockGet:=TRUE;
  ELSEIF sSecondStr="updatetool" THEN
     SockGet:=FALSE;
     WaitTime 0.5;
     SockGet:=TRUE;  
  ELSEIF sSecondStr="updatehere" THEN
     SockGet:=FALSE;
     rBackVal;
     SockGet:=TRUE; 
  ENDIF
  SockGet:=TRUE;
ENDPROC
PROC aPosition()
	MoveAbsJ [[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
	MoveAbsJ [[0,0,42,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
	MoveJ phome, vAssembly, z1, tGripper;
	MoveJ pPickWait, vAssembly, z1, tGripper;
	MoveJ pCCD1Cali, vAssembly, z1, tGripper;
	MoveJ pCCD2Cali, vAssembly, z1, tGripper;
	MoveJ pCCD1, vAssembly, z1, tGripper;
	MoveJ pPickInkpad, vAssembly, z1, tGripper;
	MoveJ pPass1, vAssembly, z1, tGripper;
	MoveL offs(pPick,0,0,25), vAssembly, z1, tGripper;
	MoveL pPick, vAssembly, z1, tGripper;
	MoveL offs(pPick,0,0,25), vAssembly, z1, tGripper;
	MoveJ pAssembly, vAssembly, z1, tGripper;
    MoveL pInsert, vAssembly, z1, tcurtool\WObj:=AssFrame;
    MoveL pPlace, vAssembly, z1, tGripper;
    MoveL pFcCalib,v100,fine,tGripper;
ENDPROC

PROC rCCD2Data(num n,robtarget pos)
    VAR string str_i;
   SockGet:=FALSE;
   MoveL offs(pos,0,0,10),v100,fine,tcp2;
   MoveL pos,v50,fine,tcp2;
   WaitTime 0.2;
   pActPos:=CRobT(\Tool:=tcp2\wobj:=wobj0);
   nPOSCCD1{n}:=pActPos.trans;
   CCD2X{n}:=ValToStr(pActPos.trans.x);
   CCD2y{n}:=ValToStr(pActPos.trans.y);
   str_i:=ValToStr(n);
   sendStr:="ok"+str_i+","+ccd2X{n}+","+ccd2y{n};
   WaitUntil SendStr="";
   SocketStr:="";
   SockGet:=TRUE;
   IF n<>9 THEN
     WaitUntil SocketStr="ok,ccd2";
   ENDIF
   MoveL offs(pos,0,0,10),v100,fine,tcp2;
ENDPROC
!rDefassFrame:Auto Updata the assembly Frame of the assembly work object by the CCD2;

TRAP tSocketError
   StopMove\Quick;
   Reset doSocketError;
   ExitCycle;
ENDTRAP
TRAP tInitiall
  StopMove\Quick;
  !bInitall:=TRUE;
  bEmptyDone:=FALSE;
  bCalibration:=FALSE;
  bWork:=FALSE;
  ExitCycle;
ENDTRAP
TRAP tEmptyDone
   StopMove\Quick;
   bEmptyDone:=TRUE;
   bInitall:=FALSE;
   bCalibration:=FALSE;
   bWork:=FALSE;
   SockGet := FALSE;
   SendStr:="resetmovefinish";
   WaitTime 0.2;
   SocketStr:="";
   WaitUntil SendStr="";
   SockGet := TRUE;
   ExitCycle;
ENDTRAP
TRAP tProcessFinish
   SockGet := FALSE;
   IF bCurPos(pCCD1,tGripper,10,10,10,wobj0)THEN
      MoveL offs(pCCD1,0,0,30),v500,z10,tGripper;
   ELSEIF bCurPos(pInsert,tCurTool,10,10,10,AssFrame) THEN
      MoveL pInsert, v200, fine, tCurTool\WObj:=AssFrame;
      MoveL pPass1, v600, z10, tGripper;
      MoveJ offs(pPass1,0,0,20), v500, z10, tGripper;
   ELSE
      TPWrite "Please jog the robot to home postion manual";
      Stop;
   ENDIF
   MoveJ offs(pPlace,0,0,30),v500,z10,tGripper;
   MoveL pPlace,v100,fine,tGripper;
   SendStr:="resetmovefinish";
   WaitTime 1;
   MoveL offs(pPlace,0,0,30),v500,z10,tGripper;
   Reset doProcessfinish;
   SocketStr:="";
   WaitUntil SendStr="";
   MoveL phome,v500,fine,tGripper;
   WaitDo doHomePos,1;
   SendStr:="gotoinitposfinish";
   WaitTime 0.5;
   SocketStr:="";
   WaitUntil SendStr="";
   SockGet := TRUE;
   ExitCycle;
ENDTRAP
PROC rBackVal()
     pActPos:=CRobT(\Tool:=tGripper\wobj:=wobj0);
     Zangle:=EulerZYX(\Z, pActPos.rot);
     Yangle:=EulerZYX(\Y, pActPos.rot);
     Xangle:=EulerZYX(\X, pActPos.rot);
     SendStr:="1,"+ValToStr(pActPos.trans.x)+","+ValToStr(pActPos.trans.y)+","+ValToStr(pActPos.trans.z)+","+ValToStr(Zangle)+","+ValToStr(Yangle)+","+ValToStr(Xangle);
     WaitUntil SendStr="";
     SocketStr:="";
ENDPROC
PROC test1()
	pAssembly.rot := pAssembly.rot*orientZyx(0,180,180);
ENDPROC
TRAP tSafetyDoor
	StopMove\Quick;
	WaitDI diSafetydoorOpen, 0;
	StartMove;
ENDTRAP
 PROC rProcessFinish()
   rMoveHome;
  !SocketSend socket1 \Str:="resetmovefinish";
   SendStr:="resetmovefinish";
   WaitTime 0.2;
   SocketStr:="";
   WaitUntil SendStr=""; 
ENDPROC
ENDMODULE