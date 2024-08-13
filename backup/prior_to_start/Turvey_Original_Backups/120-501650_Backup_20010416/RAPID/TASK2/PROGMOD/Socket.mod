MODULE Socket
!*****************************************************
!Module Name: Socket
!Version:     1.0
!Description: Get and send the message to PC
!Date:        2014/5/7
!Author:      Gavin Zhang
!*****************************************************
    
    VAR socketdev socket1;
    VAR string received_string := "";
    PERS bool SockGet:=TRUE;
    PERS String SocketStr:="";
    PERS String SendStr:="";
    VAR string USR_stTime:="Time: ";
    VAR string USR_stDate:=" / Date: ";
    VAR intnum iInitall:=0;
    PERS string recstring{99}:=["","startwork14:59:17","gotombccd14:59:19","workoffset,-0.495,-0.050,0.450,-0.500,-0.200,0.60014:59:21","robot_ponits,29.929,-311.808,-29.495,228.211,-306.313,-29.88114:59:21","gotogasket14:59:22","guide,0.028714:59:27","startpress14:59:33","startwork14:59:42","gotombccd14:59:43","workoffset,-0.465,-0.070,0.400,-0.500,-0.200,0.60014:59:45","robot_ponits,29.940,-311.789,-28.425,227.971,-306.121,-30.21014:59:46","gotogasket14:59:47","guide,-0.620414:59:51","startpress14:59:57","startwork15:00:06","gotombccd15:00:07","workoffset,-0.455,-0.080,0.410,-0.500,-0.200,0.60015:00:09","robot_ponits,29.954,-311.783,-28.139,228.206,-306.184,-30.29915:00:10","gotogasket15:00:11","guide,-1.183815:00:16","startpress15:00:21","startwork15:00:31","gotombccd15:00:33","workoffset,-0.465,-0.070,0.400,-0.500,-0.200,0.60015:00:34","robot_ponits,29.896,-311.806,-29.841,228.060,-306.195,-30.09315:00:35","gotogasket15:00:36","guide,-1.360315:00:41","startpress15:00:46","startwork15:00:56","gotombccd15:00:57","workoffset,-0.465,-0.070,0.400,-0.500,-0.200,0.60015:00:59","robot_ponits,29.926,-311.799,-30.058,228.150,-306.126,-30.24915:01:00","gotogasket15:01:01","guide,-0.502015:01:05","startpress15:01:11","startwork14:54:50","gotombccd14:54:52","workoffset,-0.475,-0.080,0.370,-0.500,-0.200,0.60014:54:53","robot_ponits,29.954,-311.795,-28.924,228.221,-306.232,-29.96714:54:54","gotogasket14:54:55","guide,-0.989614:55:00","startpress14:55:05","startwork14:55:36","gotombccd14:55:37","workoffset,-0.495,-0.070,0.510,-0.500,-0.200,0.60014:55:39","robot_ponits,29.939,-311.819,-29.660,228.036,-306.218,-29.79314:55:40","gotogasket14:55:41","guide,-0.736014:55:45","startpress14:55:51","startwork14:56:00","gotombccd14:56:01","workoffset,-0.495,-0.080,0.330,-0.500,-0.200,0.60014:56:03","robot_ponits,29.940,-311.821,-29.498,228.124,-306.173,-30.20314:56:04","gotogasket14:56:05","guide,-0.640814:56:10","startpress14:56:15","startwork14:56:45","gotombccd14:56:46","workoffset,-0.495,-0.100,0.320,-0.500,-0.200,0.60014:56:48","robot_ponits,29.928,-311.777,-28.721,228.143,-306.321,-30.10714:56:49","gotogasket14:56:49","guide,-1.225114:56:54","startpress14:57:00","startwork14:57:09","gotombccd14:57:11","workoffset,-0.465,-0.070,0.400,-0.500,-0.200,0.60014:57:12","robot_ponits,29.925,-311.801,-29.887,228.211,-306.202,-30.13414:57:13","gotogasket14:57:14","guide,-1.271614:57:19","startpress14:57:24","startwork14:57:38","gotombccd14:57:39","workoffset,-0.465,-0.070,0.400,-0.500,-0.200,0.60014:57:41","robot_ponits,29.928,-311.774,-29.386,228.137,-306.162,-30.34614:57:42","gotogasket14:57:43","guide,-1.500214:57:48","startpress14:57:53","startwork14:58:03","gotombccd14:58:04","workoffset,-0.465,-0.070,0.400,-0.500,-0.200,0.60014:58:06","robot_ponits,29.920,-311.776,-28.753,228.106,-306.232,-30.10814:58:07","gotogasket14:58:08","guide,-1.312214:58:13","startpress14:58:18","startwork14:58:27","gotombccd14:58:29","workoffset,-0.495,-0.040,0.300,-0.500,-0.200,0.60014:58:31","robot_ponits,29.930,-311.780,-28.337,228.239,-306.191,-30.11514:58:31","gotogasket14:58:32","guide,-1.141614:58:37","startpress14:58:42","startwork14:58:53","gotombccd14:58:55","workoffset,-0.465,-0.070,0.400,-0.500,-0.200,0.60014:58:56","robot_ponits,29.914,-311.842,-30.034,228.177,-306.174,-30.18214:58:57","gotogasket14:58:58","guide,0.592214:59:03","startpress14:59:08"];
    PERS string senstring{99}:=["","gotogasketfinish15:00:39","recvguide15:00:41","pressfinish15:00:52","gotoinitposfinish15:00:55","gotomenubntfinish15:00:56","gotombccdfinish15:00:59","recvworkoffsetmsg15:01:00","recvok15:01:00","gotogasketfinish15:01:03","recvguide15:01:06","pressfinish15:01:16","gotoinitposfinish15:01:19","pressfinish14:55:56","gotoinitposfinish14:55:59","gotomenubntfinish14:56:01","gotombccdfinish14:56:03","recvworkoffsetmsg14:56:04","recvok14:56:05","gotogasketfinish14:56:08","recvguide14:56:10","pressfinish14:56:21","gotoinitposfinish14:56:23","gotomenubntfinish14:56:45","gotombccdfinish14:56:48","recvworkoffsetmsg14:56:48","recvok14:56:49","gotogasketfinish14:56:52","recvguide14:56:54","pressfinish14:57:05","gotoinitposfinish14:57:08","gotomenubntfinish14:57:10","gotombccdfinish14:57:12","recvworkoffsetmsg14:57:13","recvok14:57:14","gotogasketfinish14:57:17","recvguide14:57:19","pressfinish14:57:30","gotoinitposfinish14:57:33","gotomenubntfinish14:57:38","gotombccdfinish14:57:41","recvworkoffsetmsg14:57:42","recvok14:57:43","gotogasketfinish14:57:46","recvguide14:57:48","pressfinish14:57:59","gotoinitposfinish14:58:02","gotomenubntfinish14:58:04","gotombccdfinish14:58:06","recvworkoffsetmsg14:58:07","recvok14:58:08","gotogasketfinish14:58:11","recvguide14:58:13","pressfinish14:58:24","gotoinitposfinish14:58:26","gotomenubntfinish14:58:28","gotombccdfinish14:58:30","recvworkoffsetmsg14:58:31","recvok14:58:32","gotogasketfinish14:58:35","recvguide14:58:37","pressfinish14:58:48","gotoinitposfinish14:58:51","gotomenubntfinish14:58:54","gotombccdfinish14:58:56","recvworkoffsetmsg14:58:57","recvok14:58:58","gotogasketfinish14:59:01","recvguide14:59:03","pressfinish14:59:14","gotoinitposfinish14:59:17","gotomenubntfinish14:59:18","gotombccdfinish14:59:20","recvworkoffsetmsg14:59:21","recvok14:59:22","gotogasketfinish14:59:25","recvguide14:59:27","pressfinish14:59:38","gotoinitposfinish14:59:41","gotomenubntfinish14:59:42","gotombccdfinish14:59:45","recvworkoffsetmsg14:59:46","recvok14:59:47","gotogasketfinish14:59:49","recvguide14:59:52","pressfinish15:00:02","gotoinitposfinish15:00:05","gotomenubntfinish15:00:07","gotombccdfinish15:00:09","recvworkoffsetmsg15:00:10","recvok15:00:11","gotogasketfinish15:00:14","recvguide15:00:16","pressfinish15:00:27","gotoinitposfinish15:00:29","gotomenubntfinish15:00:32","gotombccdfinish15:00:34","recvworkoffsetmsg15:00:35","recvok15:00:36"];
    PERS num ncycle1:=1;
    PERS num ncycle2:=1;
    PERS num nStrLength:=10;
	PROC main()
        IDelete iInitall;
       CONNECT iInitall WITH tInitiall;
       ISignalDI diRobReset,1,iInitall;
       SocketClose socket1;
       WaitTime 0.1;
       SocketCreate socket1;
       WaitUntil DOutput(doRob_1Excuting) = 1;
       SocketConnect socket1, "10.0.0.2", 5000;
       
       TPWrite "The network is connected"+CTime();
       ncycle1 := 1;
       ncycle2 := 1;
       Set doReady2;
     WHILE DOutput(doRob_1Excuting) = 1 DO
       WHILE SockGet=TRUE AND SocketStr="" DO
        received_string := "";
        SocketReceive socket1 \Str:=received_string;
        SocketStr:=received_string;
        TPWrite "PC->"+SocketStr;
        ncycle1 := ncycle1+1;
        nStrlength := StrLen(SocketStr);
        IF nStrlength>72 THEN
          recstring{ncycle1} := received_string;
        ELSE
          recstring{ncycle1} := received_string+CTime();
        ENDIF
        IF ncycle1 > 98 THEN
        	ncycle1 := 1;
        ENDIF
        IF SocketStr<>"" THEN
          IF StrPart(SocketStr,1,5)="error" OR SocketStr="processfinish" THEN
            IF SocketStr="processfinish" THEN
              Set doProcessFinish;
            ELSE
              Set doSocketError;
            ENDIF
          ENDIF
        ENDIF
       ENDWHILE
       WHILE SockGet=FALSE DO
         WHILE SendStr<>"" DO
          SocketSend socket1 \Str:=SendStr;
          WaitTime 0.1;
          TPWrite "ROBOT->"+SendStr;
        ncycle2 := ncycle2+1;
        senstring{ncycle2} := sendstr+CTime();
        IF ncycle2 > 98 THEN
        	ncycle2 := 1;
        ENDIF
          SendStr:="";
         ENDWHILE
       ENDWHILE 
     !WaitTime 0.1;
     !SocketStr:="";
     !SendStr:="";
   ENDWHILE
   WaitTime 0.1;
  ERROR
    IF ERRNO=ERR_SOCK_TIMEOUT THEN
	  WaitTime 0.1;
	 !RETRY;
      TPErase;
      TPWrite "The network is not connected"+"   at  "+CTime();
      ExitCycle;
	ELSEIF ERRNO=ERR_SOCK_CLOSED THEN
	  SocketClose socket1;
	! WaitTime to delay start of client.
	! Server application should start first.
	TPErase;
	  WaitTime 0.01;
      TPWrite "The network is closed"  +"   at  "+CTime();
	  ExitCycle;
     ! SocketCreate socket1;
	 ! SocketConnect socket1, "192.168.0.2", 11152;
	  RETRY;
	  ENDIF
	ENDPROC
    TRAP tInitiall
     ExitCycle;
    ENDTRAP
    
ENDMODULE