MODULE Utility(NOSTEPIN)
    
    VAR socketdev client_socket;
    VAR string received_string;
    PERS string CCD_string;
    VAR bool keep_listening := TRUE;
    VAR socketdev socket1;
    VAR string sPartx;
    VAR string sParty;
    VAR bool Ok;
    VAR string sPartangle;
    PERS num offsX:=0;
    PERS num offsY:=0;
    PERS num nAngle:=0;
    CONST num WZR:=10;
    CONST num WZH:=20;
    PERS pos poshome;
    PERS wzstationary wzrobota1:=[1];
    PERS pos PosHome1;
    PERS pos PosHome2;
    PROC SocketGet(
        var string str)
      received_string := "";
	  SocketCreate socket1;
      SocketConnect socket1, "192.168.0.2", 1025;
      ! Communication
      SocketSend socket1 \Str:=str;
      SocketReceive socket1 \Str:=received_string;
      TPWrite "Server write - " + received_string;
      IF str="sCCD1" THEN
       X1:=0;
       Y1:=0;
       nAngle1:=0;
       X2:=0;
       Y2:=0;
       nAngle2:=0;
       IF received_string="Empty" THEN
          WaitTime 0.2;
          bFull:=FALSE;
       ELSE
       ok := StrToVal(StrPart(received_string,1,3),X1);
       ok := StrToVal(StrPart(received_string,4,3),Y1);
       ok := StrToVal(StrPart(received_string,7,3),nAngle1);      
       ok := StrToVal(StrPart(received_string,11,3),X2);
       ok := StrToVal(StrPart(received_string,14,3),Y2);
       ok := StrToVal(StrPart(received_string,17,3),nAngle2);  
       bFull:=TRUE;
       ENDIF
      ELSEIF str="sCCD3" THEN
       X3:=0;
       Y3:=0;
       nAngle3:=0;
       ok := StrToVal(StrPart(received_string,1,3),X3);
       ok := StrToVal(StrPart(received_string,4,3),Y3);
       ok := StrToVal(StrPart(received_string,7,3),nAngle3);  
      ENDIF
      SocketClose socket1;
	ENDPROC
   PROC PowerUp()
     VAR shapedata shrobot1;
     pHome:=pPick;
     phome.trans.z:=pPick.trans.z+30;
     PosHome1:=phome.trans; 
     PosHome2:=phome.trans;
     PosHome1.X:=PosHome1.X-10;
     PosHome2.X:=PosHome2.X+10;
     PosHome1.Y:=PosHome1.y-10;
     PosHome2.Y:=PosHome2.Y+10;
     PosHome1.Z:=PosHome1.z-10;
     PosHome2.z:=PosHome2.z+10;
     SetSysData tGripper;
     SetSysData wobj0;
     WZBoxDef\Inside,shrobot1,PosHome1,PosHome2;
     WZDOSet\Stat,wzrobota1\Inside,shrobot1,doHomePos,1;
     TPWrite "The power on is ran";
   ENDPROC
    
  FUNC bool bCurPos(
    robtarget ComparePos,
    INOUT tooldata TCP,
    num nPosX,
     num nPosY,
     num nPosZ,
     inout wobjdata wobj)

    ! Function to compare current manipulator position with a given position
    VAR num Counter:=0;
    VAR robtarget ActualPos;
    ActualPos:=CRobT(\Tool:=TCP\WObj:=wobj);
    IF ActualPos.trans.x>ComparePos.trans.x-nPosX AND ActualPos.trans.x<ComparePos.trans.x+nPosX Counter:=Counter+1;
    IF ActualPos.trans.y>ComparePos.trans.y-nPosY AND ActualPos.trans.y<ComparePos.trans.y+nPosY Counter:=Counter+1;
    IF ActualPos.trans.z>ComparePos.trans.z-nPosZ AND ActualPos.trans.z<ComparePos.trans.z+nPosZ Counter:=Counter+1;
    IF ActualPos.rot.q1>ComparePos.rot.q1-0.1 AND ActualPos.rot.q1<ComparePos.rot.q1+0.1 Counter:=Counter+1;
    IF ActualPos.rot.q2>ComparePos.rot.q2-0.1 AND ActualPos.rot.q2<ComparePos.rot.q2+0.1 Counter:=Counter+1;
    IF ActualPos.rot.q3>ComparePos.rot.q3-0.1 AND ActualPos.rot.q3<ComparePos.rot.q3+0.1 Counter:=Counter+1;
    IF ActualPos.rot.q4>ComparePos.rot.q4-0.1 AND ActualPos.rot.q4<ComparePos.rot.q4+0.1 Counter:=Counter+1;
    RETURN Counter=7;
  ENDFUNC
  FUNC bool bCurrentPos(
    robtarget ComparePos,
    INOUT tooldata TCP)

    ! Function to compare current manipulator position with a given position
    VAR num Counter:=0;
    VAR robtarget ActualPos;

    ActualPos:=CRobT(\Tool:=TCP\WObj:=wobj0);
    IF ActualPos.trans.x>ComparePos.trans.x-150 AND ActualPos.trans.x<ComparePos.trans.x+150 Counter:=Counter+1;
    IF ActualPos.trans.y>ComparePos.trans.y-150 AND ActualPos.trans.y<ComparePos.trans.y+150 Counter:=Counter+1;
    IF ActualPos.trans.z>ComparePos.trans.z-150 AND ActualPos.trans.z<ComparePos.trans.z+150 Counter:=Counter+1;
    IF ActualPos.rot.q1>ComparePos.rot.q1-0.1 AND ActualPos.rot.q1<ComparePos.rot.q1+0.1 Counter:=Counter+1;
    IF ActualPos.rot.q2>ComparePos.rot.q2-0.1 AND ActualPos.rot.q2<ComparePos.rot.q2+0.1 Counter:=Counter+1;
    IF ActualPos.rot.q3>ComparePos.rot.q3-0.1 AND ActualPos.rot.q3<ComparePos.rot.q3+0.1 Counter:=Counter+1;
    IF ActualPos.rot.q4>ComparePos.rot.q4-0.1 AND ActualPos.rot.q4<ComparePos.rot.q4+0.1 Counter:=Counter+1;
    RETURN Counter=7;
  ENDFUNC
	PROC Absj()
		MoveAbsJ [[-90,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
		MoveAbsJ [[0,0,42,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs, v1000, z50, tool0;
	ENDPROC
    PROC serversocket()
  SocketCreate temp_socket;
  SocketBind temp_socket, "192.168.0.5", 1025;
  SocketListen temp_socket;
  WHILE keep_listening DO
! Waiting for a connection request
  SocketAccept temp_socket, client_socket;
! Communication
  SocketReceive client_socket \Str:=received_string;
  TPWrite "Client wrote - " + received_string;
  received_string := "";
  SocketSend client_socket \Str:="Message acknowledged";
! Shutdown the connection
  SocketReceive client_socket \Str:=received_string;
  TPWrite "Client wrote - " + received_string;
  SocketSend client_socket \Str:="Shutdown acknowledged";
  SocketClose client_socket;
  ENDWHILE
SocketClose temp_socket;
ENDPROC
    
ENDMODULE