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
    PERS bool SockGet:=FALSE;
    PERS String SocketStr:="startpress";
    PERS String SendStr:="";
    VAR string USR_stTime:="Time: ";
    VAR string USR_stDate:=" / Date: ";
    VAR intnum iInitall:=0;
    PERS string recstring{99}:=["","startwork13:43:36","gotombccd13:43:37","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:43:39","robot_ponits,27.450,-312.599,-32.232,227.345,-306.804,-30.22813:43:40","gotogasket13:43:41","guide,-0.636313:43:46","startpress13:43:50","startwork13:44:04","gotombccd13:44:05","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:44:07","robot_ponits,27.442,-312.590,-32.179,227.386,-306.799,-29.87513:44:08","gotogasket13:44:09","guide,-0.293513:44:14","startpress13:44:18","startwork13:44:34","gotombccd13:44:35","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:44:37","robot_ponits,27.446,-312.554,-32.324,227.415,-306.930,-29.65013:44:38","gotogasket13:44:39","guide,-1.225813:44:44","startpress13:44:48","startwork13:45:00","gotombccd13:45:01","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:45:03","robot_ponits,27.442,-312.564,-32.438,227.550,-307.134,-29.83713:45:04","gotogasket13:45:05","guide,-0.720413:45:10","startpress13:45:14","startwork13:45:47","gotombccd13:45:49","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:45:50","robot_ponits,27.458,-312.575,-32.079,227.426,-307.093,-29.78713:45:51","gotogasket13:45:52","guide,-0.906313:45:57","startpress13:46:01","startwork13:46:18","gotombccd13:46:20","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:46:22","robot_ponits,27.442,-312.621,-32.218,227.265,-307.059,-29.38213:46:22","gotogasket13:46:23","guide,-1.156713:46:28","startpress13:46:33","startwork13:38:26","gotombccd13:38:27","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:38:29","robot_ponits,27.441,-312.603,-32.407,227.323,-307.137,-30.08213:38:30","gotogasket13:38:31","guide,-0.778313:38:36","startpress13:38:40","startwork13:38:53","gotombccd13:38:54","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:38:56","robot_ponits,27.458,-312.544,-32.314,227.391,-306.988,-29.63613:38:57","gotogasket13:38:58","guide,-0.568813:39:03","startpress13:39:07","startwork13:40:09","gotombccd13:40:10","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:40:12","robot_ponits,27.433,-312.574,-32.262,227.436,-306.754,-29.98413:40:13","gotogasket13:40:13","guide,-1.109413:40:19","startpress13:40:23","startwork13:40:36","gotombccd13:40:37","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:40:39","robot_ponits,27.457,-312.604,-32.399,227.371,-306.866,-29.56513:40:40","gotogasket13:40:41","guide,-1.080613:40:46","startpress13:40:50","startwork13:41:11","gotombccd13:41:12","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:41:14","robot_ponits,27.431,-312.608,-32.281,227.294,-306.920,-29.98513:41:15","gotogasket13:41:16","guide,-0.974413:41:21","startpress13:41:25","startwork13:42:11","gotombccd13:42:13","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:42:14","robot_ponits,27.471,-312.552,-32.338,227.640,-307.348,-29.72013:42:15","gotogasket13:42:16","guide,-1.510813:42:21","startpress13:42:26","startwork13:42:40","gotombccd13:42:42","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:42:43","robot_ponits,27.476,-312.582,-32.251,227.453,-306.992,-29.86613:42:44","gotogasket13:42:45","guide,-0.715013:42:50","startpress13:42:54","startwork13:43:06","gotombccd13:43:08","workoffset,-0.270,-0.670,0.400,0.300,0.000,-0.20013:43:10","robot_ponits,27.459,-312.576,-32.255,227.292,-307.030,-29.46313:43:11","gotogasket13:43:11","guide,-0.959913:43:17","startpress13:43:21"];
    PERS string senstring{99}:=["","pressfinish13:40:30","gotoinitposfinish13:40:33","gotomenubntfinish13:40:37","gotombccdfinish13:40:39","recvworkoffsetmsg13:40:40","recvok13:40:41","gotogasketfinish13:40:44","recvguide13:40:46","pressfinish13:40:57","gotoinitposfinish13:41:01","gotomenubntfinish13:41:12","gotombccdfinish13:41:14","recvworkoffsetmsg13:41:15","recvok13:41:16","gotogasketfinish13:41:19","recvguide13:41:21","pressfinish13:41:32","gotoinitposfinish13:41:36","gotomenubntfinish13:42:12","gotombccdfinish13:42:14","recvworkoffsetmsg13:42:15","recvok13:42:16","gotogasketfinish13:42:19","recvguide13:42:22","pressfinish13:42:33","gotoinitposfinish13:42:36","gotomenubntfinish13:42:41","gotombccdfinish13:42:43","recvworkoffsetmsg13:42:44","recvok13:42:45","gotogasketfinish13:42:49","recvguide13:42:51","pressfinish13:43:02","gotoinitposfinish13:43:05","gotomenubntfinish13:43:07","gotombccdfinish13:43:09","recvworkoffsetmsg13:43:10","recvok13:43:11","gotogasketfinish13:43:15","recvguide13:43:17","pressfinish13:43:28","gotoinitposfinish13:43:31","gotomenubntfinish13:43:36","gotombccdfinish13:43:39","recvworkoffsetmsg13:43:40","recvok13:43:40","gotogasketfinish13:43:44","recvguide13:43:46","pressfinish13:43:57","gotoinitposfinish13:44:00","gotomenubntfinish13:44:05","gotombccdfinish13:44:07","recvworkoffsetmsg13:44:08","recvok13:44:09","gotogasketfinish13:44:12","recvguide13:44:14","pressfinish13:44:25","gotoinitposfinish13:44:29","gotomenubntfinish13:44:35","gotombccdfinish13:44:37","recvworkoffsetmsg13:44:38","recvok13:44:39","gotogasketfinish13:44:42","recvguide13:44:44","pressfinish13:44:55","gotoinitposfinish13:44:59","gotomenubntfinish13:45:00","gotombccdfinish13:45:03","recvworkoffsetmsg13:45:04","recvok13:45:04","gotogasketfinish13:45:08","recvguide13:45:10","pressfinish13:45:21","gotoinitposfinish13:45:24","gotomenubntfinish13:45:48","gotombccdfinish13:45:50","recvworkoffsetmsg13:45:51","recvok13:45:52","gotogasketfinish13:45:55","recvguide13:45:58","pressfinish13:46:09","gotoinitposfinish13:46:12","gotomenubntfinish13:46:19","gotombccdfinish13:46:21","recvworkoffsetmsg13:46:22","recvok13:46:23","gotogasketfinish13:46:27","recvguide13:46:29","gotogasketfinish13:39:01","recvguide13:39:03","pressfinish13:39:14","gotoinitposfinish13:39:17","gotomenubntfinish13:40:09","gotombccdfinish13:40:12","recvworkoffsetmsg13:40:12","recvok13:40:13","gotogasketfinish13:40:17","recvguide13:40:19"];
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