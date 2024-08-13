MODULE InitaPos
    CONST jointtarget J_Init:=[[0,0,69.8,0,19,0],[0,0,0,0,0,0]];
    PROC rSafetyHome()
    VelSet 100,500;
    IF bCurPos(pPASS2,tGripper,10,10,10,wobj0)THEN
      MoveJ ppass2,v500,fine,tGripper;
    ENDIF
    IF bCurPos(pHome,tGripper,10,10,10,wobj0)THEN
      MoveJ ppass2,v500,fine,tGripper;
    ENDIF
    IF bCurPos(pPlace,tGripper,10,10,10,wobj0)THEN
      MoveJ pPlace,v500,z10,tGripper;
      MoveJ offs(pPlace,0,0,30),v500,z10,tGripper;
      MoveJ ppass2,v500,fine,tGripper;
    ENDIF
    IF bCurPos(pPick,tGripper,10,10,10,wobj0) THEN
      MoveJ offs(pPick,0,0,20), v500, fine, tGripper;
      MoveJ ppass2, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pCCD1Cali,tGripper,10,10,10,wobj0) THEN
      MoveJ pCCD1Cali, v500, z10, tGripper;
      MoveJ offs(pCCD1Cali,0,0,30), v500, z10, tGripper;
      MoveJ ppass2, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pCCD2Cali,tGripper,10,10,10,wobj0) THEN
      MoveJ Offs(pCCD2Cali,0,0,30), v100, fine, tGripper;
      MoveL Offs(pPass2,0,0,40), v500, z20, tGripper;
      MoveL ppass2, v500, fine, tGripper;
    ENDIF
    IF bCurPos(ppass1,tGripper,10,10,10,wobj0) THEN
      MoveJ ppass2, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pFcCalib,tGripper,10,10,10,wobj0) THEN
      MoveJ offs(pFcCalib,0,0,50), v500, z10, tGripper;
      MoveJ ppass2, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pPlace,tGripper,10,10,10,wobj0) THEN
      MoveJ Offs(pPlace,0,0,20), v500, fine, tGripper;
      MoveJ ppass2, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pInsert,tCurTool,10,10,10,AssFrame) THEN
      MoveJ pPass1, v500, fine, tGripper;
      MoveJ pPass2, v500, fine, tGripper;
    ENDIF
    IF bCurPos(pInsert,tool0,10,10,10,wobj0) THEN
      MoveJ pPass1, v500, fine, tGripper;
      MoveJ pPass2, v500, fine, tGripper;
    ENDIF
    J_Temp:=CJointT();
    IF ABS(J_Temp.robax.rax_1)<2 AND ABS(J_Temp.robax.rax_2)<2 AND ABS(J_Temp.robax.rax_3)<2 AND ABS(J_Temp.robax.rax_4)<2 AND ABS(J_Temp.robax.rax_5)<2 AND ABS(J_Temp.robax.rax_6)<3 THEN
      MoveJ pPass2, v200, z5, tGripper;
    ENDIF
    IF bCurrentPos(pPASS2,tGripper)=FALSE THEN
      ! If no known position is found, check if the robot is in a specified 
      ! window and move him to the first position in the program
      pActPos:=CRobT(\Tool:=tGripper\WObj:=wobj0);
      IF (pPick.trans.x<pActPos.trans.x AND pActPos.trans.x<pCCD2Cali.trans.x) AND (pPick.trans.Y<pActPos.trans.Y AND pActPos.trans.Y<0) AND pActPos.trans.z>pAssembly.trans.z THEN
        MoveL offs(pActPos,0,0,60),v300,z20,tGripper;
        MoveJ pPass2, v200, z5, tGripper;
      ELSE
          TPErase;
          TPWrite "Please switch robot to Manual mode";
          !TPErase;
          Stop;
          MoveJ ppass2,v300,z20,tGripper;  
      ENDIF
    ELSE
       !MoveJ pPass2, v300, z20, tGripper\WObj:=wobj0;
       MoveJ ppass2,v300,z20,tGripper;
      ENDIF
    MoveJ ppass2,v300,fine,tGripper;
    endproc
    PROC GoInit()
        rSafetyHome;
        J_Temp:=CJointT();
        J_Temp.robax.rax_2:=J_Init.robax.rax_2;
        J_Temp.robax.rax_4:=J_Init.robax.rax_4;
        J_Temp.robax.rax_6:=J_Init.robax.rax_6;
        MoveAbsJ J_Temp \NoEOffs,v100,fine,tGripper;
        J_Temp:=CJointT();
        J_Temp.robax.rax_3:=J_Init.robax.rax_3;
        J_Temp.robax.rax_5:=J_Init.robax.rax_5;
        MoveAbsJ J_Temp \NoEOffs,v100,fine,tGripper;
        J_Temp:=CJointT();
        J_Temp.robax.rax_1:=J_Init.robax.rax_1;
        MoveAbsJ J_Temp \NoEOffs,v100,FINE,tGripper;
        Stop;
    ENDPROC
    
ENDMODULE