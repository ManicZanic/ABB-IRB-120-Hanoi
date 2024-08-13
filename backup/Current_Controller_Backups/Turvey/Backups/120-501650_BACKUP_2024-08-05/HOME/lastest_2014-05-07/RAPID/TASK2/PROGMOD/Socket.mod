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
    PERS string recstring{99}:=["","gotogasket13:23:45","guide,-1.865413:23:50","startpress13:23:55","gotoinitpos13:24:02","startwork13:24:08","gotombccd13:24:10","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:24:12","robot_ponits,28.791,-310.879,-90.914,226.964,-306.659,-30.66213:24:13","gotogasket13:24:13","guide,-0.412413:24:18","startpress13:24:23","gotoinitpos13:24:30","startwork13:24:35","gotombccd13:24:37","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:24:39","robot_ponits,28.777,-310.875,-90.772,227.139,-306.650,-30.44713:24:40","gotogasket13:24:40","guide,-1.308613:24:45","startpress13:24:50","gotoinitpos13:24:57","startwork13:25:01","gotombccd13:25:04","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:25:06","robot_ponits,28.779,-310.889,-90.553,227.135,-306.833,-30.58613:25:07","gotogasket13:25:07","guide,-2.027413:25:11","startpress13:25:16","gotoinitpos13:25:24","startwork13:25:28","gotombccd13:25:30","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:25:32","robot_ponits,28.773,-310.870,-90.936,227.062,-306.753,-30.43113:25:33","gotogasket13:25:33","guide,-0.639013:25:38","startpress13:25:43","gotoinitpos13:25:50","startwork13:25:57","gotombccd13:25:59","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:26:01","robot_ponits,28.784,-310.892,-90.705,227.203,-306.795,-30.69313:26:02","gotogasket13:26:02","guide,0.493413:26:06","startpress13:26:11","gotoinitpos13:26:19","startpress13:20:13","gotoinitpos13:20:20","startwork13:20:31","gotombccd13:20:33","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:20:35","robot_ponits,28.791,-310.884,-90.772,227.022,-306.953,-29.91913:20:36","gotogasket13:20:36","guide,-2.437913:20:41","startpress13:20:46","gotoinitpos13:20:53","startwork13:20:58","gotombccd13:21:00","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:21:03","robot_ponits,28.789,-310.876,-90.369,226.963,-306.619,-30.44613:21:03","gotogasket13:21:04","guide,-1.142613:21:08","startpress13:21:13","gotoinitpos13:21:21","startwork13:21:26","gotombccd13:21:28","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:21:30","robot_ponits,28.774,-310.879,-90.853,227.149,-306.636,-30.67313:21:31","gotogasket13:21:31","guide,-0.642613:21:35","startpress13:21:41","gotoinitpos13:21:48","startwork13:21:59","gotombccd13:22:02","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:22:04","robot_ponits,28.780,-310.889,-90.825,227.143,-306.812,-30.41913:22:04","gotogasket13:22:05","guide,-0.389713:22:09","startpress13:22:14","gotoinitpos13:22:22","startwork13:22:36","gotombccd13:22:38","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:22:40","robot_ponits,28.781,-310.867,-90.736,227.115,-306.741,-30.13713:22:41","gotogasket13:22:41","guide,-0.841813:22:46","startpress13:22:51","gotoinitpos13:22:58","startwork13:23:09","gotombccd13:23:11","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:23:13","robot_ponits,28.790,-310.894,-90.536,227.207,-306.784,-30.58513:23:14","gotogasket13:23:14","guide,0.703513:23:19","startpress13:23:24","gotoinitpos13:23:31","startwork13:23:40","gotombccd13:23:42","workoffset,0.100,-0.200,0.000,0.000,0.000,0.00013:23:45","robot_ponits,28.786,-310.892,-90.852,227.041,-306.930,-30.12413:23:45"];
    PERS string senstring{99}:=["","gotogasketfinish13:23:49","recvguide13:23:50","pressfinish13:24:02","gotoinitposfinish13:24:05","gotomenubntfinish13:24:09","gotombccdfinish13:24:12","recvworkoffsetmsg13:24:13","recvok13:24:13","gotogasketfinish13:24:17","recvguide13:24:18","pressfinish13:24:30","gotoinitposfinish13:24:33","gotomenubntfinish13:24:36","gotombccdfinish13:24:39","recvworkoffsetmsg13:24:40","recvok13:24:40","gotogasketfinish13:24:44","recvguide13:24:45","pressfinish13:24:57","gotoinitposfinish13:25:00","gotomenubntfinish13:25:03","gotombccdfinish13:25:06","recvworkoffsetmsg13:25:06","recvok13:25:07","gotogasketfinish13:25:10","recvguide13:25:11","pressfinish13:25:24","gotoinitposfinish13:25:27","gotomenubntfinish13:25:29","gotombccdfinish13:25:32","recvworkoffsetmsg13:25:33","recvok13:25:33","gotogasketfinish13:25:37","recvguide13:25:38","pressfinish13:25:50","gotoinitposfinish13:25:53","gotomenubntfinish13:25:58","gotombccdfinish13:26:01","recvworkoffsetmsg13:26:01","recvok13:26:02","gotogasketfinish13:26:05","recvguide13:26:06","pressfinish13:26:19","gotoinitposfinish13:26:22","pressfinish13:20:20","gotoinitposfinish13:20:23","gotomenubntfinish13:20:32","gotombccdfinish13:20:35","recvworkoffsetmsg13:20:36","recvok13:20:36","gotogasketfinish13:20:40","recvguide13:20:41","pressfinish13:20:53","gotoinitposfinish13:20:56","gotomenubntfinish13:21:00","gotombccdfinish13:21:03","recvworkoffsetmsg13:21:03","recvok13:21:03","gotogasketfinish13:21:07","recvguide13:21:08","pressfinish13:21:20","gotoinitposfinish13:21:23","gotomenubntfinish13:21:27","gotombccdfinish13:21:30","recvworkoffsetmsg13:21:30","recvok13:21:31","gotogasketfinish13:21:35","recvguide13:21:35","pressfinish13:21:48","gotoinitposfinish13:21:51","gotomenubntfinish13:22:01","gotombccdfinish13:22:04","recvworkoffsetmsg13:22:04","recvok13:22:05","gotogasketfinish13:22:08","recvguide13:22:09","pressfinish13:22:21","gotoinitposfinish13:22:24","gotomenubntfinish13:22:37","gotombccdfinish13:22:40","recvworkoffsetmsg13:22:41","recvok13:22:41","gotogasketfinish13:22:45","recvguide13:22:46","pressfinish13:22:58","gotoinitposfinish13:23:01","gotomenubntfinish13:23:10","gotombccdfinish13:23:13","recvworkoffsetmsg13:23:14","recvok13:23:14","gotogasketfinish13:23:18","recvguide13:23:19","pressfinish13:23:31","gotoinitposfinish13:23:34","gotomenubntfinish13:23:42","gotombccdfinish13:23:44","recvworkoffsetmsg13:23:45","recvok13:23:45"];
    PERS num ncycle1:=1;
    PERS num ncycle2:=1;
    PERS num nStrLength:=11;
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