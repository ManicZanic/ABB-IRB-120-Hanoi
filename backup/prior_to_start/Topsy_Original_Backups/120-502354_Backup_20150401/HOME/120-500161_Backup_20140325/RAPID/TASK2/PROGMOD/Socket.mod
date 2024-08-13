MODULE Socket
    VAR socketdev socket1;
    VAR string received_string := "";
    PERS bool SockGet:=TRUE;
    PERS String SocketStr:="";
    PERS String SendStr:="";
    VAR string USR_stTime:="Time: ";
    VAR string USR_stDate:=" / Date: ";
    VAR intnum iInitall:=0;
    PERS string recstring{99}:=["","startwork12:16:23","gotombccd12:16:26","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00012:16:28","processfinish12:16:29","gotoinitpos12:16:30","startwork12:17:05","gotombccd12:17:07","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00012:17:10","processfinish12:17:10","gotoinitpos12:17:12","startwork12:17:34","gotombccd12:17:36","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00012:17:38","processfinish12:17:39","gotoinitpos12:17:40","startwork12:17:55","gotombccd12:17:57","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00012:18:00","processfinish12:18:00","gotoinitpos12:18:02","startwork12:18:25","gotombccd12:18:27","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00012:18:29","processfinish12:18:30","gotoinitpos12:18:31","startwork12:19:00","gotombccd12:19:02","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00012:19:04","processfinish12:19:05","gotoinitpos12:19:06","startwork12:19:21","gotombccd12:19:24","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00012:19:26","processfinish12:19:27","gotoinitpos12:19:28","startwork12:19:46","gotombccd12:19:48","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00012:19:50","processfinish12:19:51","gotoinitpos12:19:52","startwork19:07:46","gotombccd19:07:48","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:07:51","processfinish19:07:51","gotoinitpos19:07:52","startwork19:08:18","gotombccd19:08:20","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:08:22","processfinish19:08:23","gotoinitpos19:08:24","startwork19:08:51","gotombccd19:08:54","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:08:56","processfinish19:08:56","gotoinitpos19:08:58","startwork19:09:22","gotombccd19:09:25","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:09:27","processfinish19:09:28","gotoinitpos19:09:29","startwork19:10:00","gotombccd19:10:02","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:10:04","processfinish19:10:05","gotoinitpos19:10:06","startwork19:10:54","gotombccd19:10:57","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:10:59","processfinish19:11:00","gotoinitpos19:11:01","startwork19:11:29","gotombccd19:11:31","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:11:33","processfinish19:11:34","gotoinitpos19:11:35","startwork19:12:07","gotombccd19:12:10","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:12:12","processfinish19:12:12","gotoinitpos19:12:14","startwork19:12:47","gotombccd19:12:49","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:12:51","processfinish19:12:52","gotoinitpos19:12:53","startwork19:13:22","gotombccd19:13:24","workoffset,0.010,-0.280,0.000,0.000,0.000,0.00019:13:27","processfinish19:13:27","gotoinitpos19:13:28","gotoinitpos21:06:31","startwork21:06:36","gotombccd21:06:40","workoffset,38.578,-311.221,90.022,228.744,-307.253,105.369,-0.140,-0.190,0.000","gotogasket21:06:43","guide,-1.273321:06:49","startpress21:07:04","gotoinitpos21:07:08"];
    PERS string senstring{99}:=["","gotomenubntfinish12:16:25","gotombccdfinish12:16:28","recvworkoffsetmsg12:16:28","ok12:16:30","gotomenubntfinish12:17:07","gotombccdfinish12:17:10","recvworkoffsetmsg12:17:10","ok12:17:12","gotomenubntfinish12:17:35","gotombccdfinish12:17:38","recvworkoffsetmsg12:17:38","ok12:17:40","gotomenubntfinish12:17:57","gotombccdfinish12:18:00","recvworkoffsetmsg12:18:00","ok12:18:02","gotomenubntfinish12:18:26","gotombccdfinish12:18:29","recvworkoffsetmsg12:18:29","ok12:18:31","gotomenubntfinish12:19:01","gotombccdfinish12:19:04","recvworkoffsetmsg12:19:05","ok12:19:07","gotomenubntfinish12:19:23","gotombccdfinish12:19:26","recvworkoffsetmsg12:19:26","ok12:19:28","gotomenubntfinish12:19:47","gotombccdfinish12:19:50","recvworkoffsetmsg12:19:50","ok12:19:53","gotomenubntfinish19:07:48","gotombccdfinish19:07:51","recvworkoffsetmsg19:07:51","ok19:07:53","gotomenubntfinish19:08:19","gotombccdfinish19:08:22","recvworkoffsetmsg19:08:23","ok19:08:25","gotomenubntfinish19:08:53","gotombccdfinish19:08:56","recvworkoffsetmsg19:08:56","ok19:08:58","gotomenubntfinish19:09:24","gotombccdfinish19:09:27","recvworkoffsetmsg19:09:27","ok19:09:29","gotomenubntfinish19:10:01","gotombccdfinish19:10:04","recvworkoffsetmsg19:10:04","ok19:10:07","gotomenubntfinish19:10:56","gotombccdfinish19:10:59","recvworkoffsetmsg19:10:59","ok19:11:01","gotomenubntfinish19:11:30","gotombccdfinish19:11:33","recvworkoffsetmsg19:11:33","ok19:11:35","gotomenubntfinish19:12:09","gotombccdfinish19:12:12","recvworkoffsetmsg19:12:12","ok19:12:14","gotomenubntfinish19:12:48","gotombccdfinish19:12:51","recvworkoffsetmsg19:12:52","ok19:12:54","gotomenubntfinish19:13:24","gotombccdfinish19:13:26","recvworkoffsetmsg19:13:27","ok19:13:29","pressfinish21:04:42","gotoinitposfinish21:04:45","gotomenubntfinish21:04:56","gotombccdfinish21:05:00","ok21:05:04","gotomenubntfinish21:06:00","gotombccdfinish21:06:05","recvworkoffset21:06:06","gotogasketfinish21:06:11","recvgudie21:06:12","pressfinish21:06:31","gotoinitposfinish21:06:34","gotomenubntfinish21:06:38","gotombccdfinish21:06:42","recvworkoffset21:06:43","gotogasketfinish21:06:48","recvgudie21:06:49","pressfinish21:07:08","gotoinitposfinish21:07:11","gotomenubntfinish21:07:28","gotombccdfinish21:07:32","recvworkoffset21:07:33","gotogasketfinish21:07:38","recvgudie21:07:39","pressfinish21:07:58","gotoinitposfinish21:08:01"];
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
       ncycle1 := 1;
       ncycle2 := 1;
       Set doReady2;
       TPWrite "The network is connected>>>>"+CTime();
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
              Set doSocketError;
              Waituntil DOutput(doHomePos)=1;
              SocketSend socket1 \Str:="resetmovefinish";
            ENDIF
            Set doSocketError;
          ENDIF
        ENDIF
       ENDWHILE
       WHILE SockGet=FALSE DO
         WHILE SendStr<>"" DO
          SocketSend socket1 \Str:=SendStr;
          WaitTime 0.1;
          !SendStr:="";
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