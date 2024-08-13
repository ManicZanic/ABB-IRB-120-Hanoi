########################
# DC Link
########################
setvar -var 10 -value 0
getkey -id "Drive1Select" -var 10 -strvar $ANSWER -errlabel ERROR
goto -strvar $ANSWER

########################################
# DC Link System 04 Start
########################################

########################
# Small robots
########################
#DCRC1
echo -text "Installing config for DC link (DCR1C1)"
config -filename  $BOOTPATH/drvcfg/INT_DCR1C1_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO2_DM1.cfg -domain MOC -internal
goto -label DRIVE_UNIT
########################
# Large robots
########################
##DC for 6600
#DCR3C30
echo -text "Installing config for DC link (DCR3C3)"
config -filename  $BOOTPATH/drvcfg/INT_DCR3C3_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO0_DM1.cfg -domain MOC -internal
goto -label DRIVE_UNIT
##DC for 7600
#DCR3C3
echo -text "Installing config for DC link (DCR3C3)"
config -filename  $BOOTPATH/drvcfg/INT_DCR3C3_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO6_DM1.cfg -domain MOC -internal
goto -label DRIVE_UNIT
########################
# External axes
########################
#DCR2
echo -text "Installing config for DC link (DCR2C2)"
config -filename  $BOOTPATH/drvcfg/INT_DCR2C2_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO2_DM1.cfg -domain MOC -internal
goto -label DRIVE_UNIT
#DCR2C4
echo -text "Installing config for DC link (DCR2C4)"
config -filename  $BOOTPATH/drvcfg/INT_DCR2C4_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO2_DM1.cfg -domain MOC -internal
goto -label DRIVE_UNIT

########################################
# DC Link System 04 End
########################################

########################################
# DC Link System 09 Start
########################################

########################
# Small robots
########################

# DC for IRC5 Compact on 1-phase = MDU-430C
#DC430A1
echo -text "Installing config for DC link (MDU-430C 1-phase)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU430C_430_1PH_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU430C_430_1PH_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO7_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

# DC for Small robots = MDU-430A
#DC430A2
echo -text "Installing config for DC link (MDU-430A)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU430A_430_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU430A_430_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO2_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

# DC for Small Paint robots = MDU-430A
#DC430A3
echo -text "Installing config for DC link (MDU-430A)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU430A_430_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU430A_430_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO5_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

# DC for IRC5 Compact on 3-phase = MDU-430C
#DC430A4
echo -text "Installing config for DC link (MDU-430C 3-phase)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU430C_430_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU430C_430_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO2_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

# DC for Small robots 1-phase = MDU-430A
#DC430A5
echo -text "Installing config for DC link (MDU-430A 1-phase)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU430A_430_1PH_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU430A_430_1PH_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO2_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

########################
# Medium robots  (NOT USED)
########################

#DC430B
#echo -text "Installing config for DC link (MDU-430B)"
#config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU430B_430_DM1.cfg -domain MOC -internal
#config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU430B_430_DM1.cfg.enc -domain MOC -internal
#config -filename  $BOOTPATH/drvcfg/INT_TRAFO2_DM1.cfg -domain MOC -internal
#goto -label DRIVE_MODULE

########################
# Large robots 
########################

# DC for 4400/6400 = MDU-790A
#DC790A1 
echo -text "Installing config for DC link (MDU-790A)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU790A_430_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU790A_430_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO2_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

# DC for 66xx/4600 = MDU-790A
#DC790A2
echo -text "Installing config for DC link (MDU-790A)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU790A_790_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU790A_790_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO0_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

# DC for 7600 & 5500 = MDU-790A
#DC790A3
echo -text "Installing config for DC link (MDU-790A)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU790A_790_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU790A_790_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO6_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

# DC for 5400 = MDU-790A
#DC790A4
echo -text "Installing config for DC link (MDU-790A)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU790A_430_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU790A_430_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO5_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

# DC for 6620LX = MDU-790A
#DC790A5
echo -text "Installing config for DC link (MDU-790A)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_MDU790A_790_LX_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_MDU790A_790_LX_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_TRAFO0_DM1.cfg -domain MOC -internal
goto -label DRIVE_MODULE

########################
# Drive module 
########################
#DRIVE_MODULE
setvar -var 10 -value 0
getkey -id "Drive1Module" -var 10 -strvar $ANSWER -errlabel ERROR
goto -strvar $ANSWER

########################
# Drive module for small & medium robots 
########################
#DM430A
echo -text "Installing config for drive module"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_MODULE1_MDU430A.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_MODULE1_MDU430A.cfg -domain MOC
goto -label DRIVE_UNIT

########################
# Drive module for large robots (and 340 & 360)
########################
#DM790A
echo -text "Installing config for drive module"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_MODULE1_MDU790A.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_MODULE1_MDU790A.cfg -domain MOC
goto -label DRIVE_UNIT

########################################
# DC Link System 09 End
########################################

########################
# Drive unit
########################
#DRIVE_UNIT
setvar -var 10 -value 0
getkey -id "Drive1Unit" -var 10 -strvar $ANSWER -errlabel ERROR
goto -strvar $ANSWER

########################################
# Drive unit System 04 Start
########################################

#################
# 140 & 1400
#################
#DRIVE_3B3A
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_3B3A_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_3B3A_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_3B3A_DM1.cfg -domain MOC
goto -label EXTAXPOS1_LABEL
#################
# 1600 & 2400
#################
#DRIVE_2E2C2B
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_2E2C2B_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_2E2C2B_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_2E2C2B_DM1.cfg -domain MOC
goto -label EXTAXPOS1_LABEL
#################
# 340
#################
#DRIVE_3E1C
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_3E1C_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_3E1C_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_3E1C_DM1.cfg -domain MOC
goto -label EXTAXPOS1_LABEL
#################
# 4400 & 940
#################
#DRIVE_3G3T
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_3G3T_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_3G3T_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_3G3T_DM1.cfg -domain MOC
goto -label EXTAXPOS1_LABEL
#################
# 6600 & 6650
#################
#DRIVE_3V3W_LOW
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_3V3W_LOW_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_3V3W_LOW_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_3V3W_LOW_DM1.cfg -domain MOC
goto -label EXTAXPOS1_LABEL
#################
# 6400R
#################
#DRIVE_3V3W_262V
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_3V3W_262V_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_3V3W_262V_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_3V3W_262V_DM1.cfg -domain MOC
goto -label EXTAXPOS1_LABEL
#################
# 7600
#################
#DRIVE_3V3W_HIGH
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/SEC_DRIVE_3V3W_HIGH_DM1.cfg.enc -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_3V3W_HIGH_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_3V3W_HIGH_DM1.cfg -domain MOC
goto -label EXTAXPOS1_LABEL

########################################
# Drive unit System 04 End
########################################

########################################
# Drive unit System 09 Start
########################################

########################
# Compact Controller
########################

# MDU430A1 = MDU-430C 1-Phase
#DU430A1
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_MDU430C_430_1PH_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS1_LABEL

# MDU430A4 = MDU-430C 3-Phase
#DU430A4
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_MDU430C_430_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS1_LABEL

########################
# Small robots
########################

# MDU430A2 = MDU-430A 
#DU430A2
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_MDU430A_430_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS1_LABEL

# MDU430A5 = MDU-430A 1-Phase
#DU430A5
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_MDU430A_430_1PH_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS1_LABEL

########################
# Medium robots
########################

#DU430B
#echo -text "Installing config for drive unit"
#config -filename  $BOOTPATH/drvcfg/INT_DRIVE_MDU430B_430_DM1.cfg -domain MOC -internal
#goto -label EXTAXPOS1_LABEL

########################
# Large robots
########################
# MDU790A1 = MDU-790A
#DU790A1
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_MDU790A_430_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS1_LABEL

# MDU790A2 = MDU-790A
#DU790A2
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_MDU790A_790_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS1_LABEL

# MDU790A3 = MDU-790A for 2400 - special case!! SPR1038464
#DU790A3
echo -text "Installing config for drive unit"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_MDU790A_430_B_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS1_LABEL

########################################
# Drive unit System 09 End
########################################

########################
# Drive unit external 1
########################
#EXTAXPOS1_LABEL
setvar -var 10 -value 0
getkey -id "ExtAx1Pos1Select" -var 10 -strvar $ANSWER -errlabel END_LABEL
goto -strvar $ANSWER

#EXTAXPOS1NN
echo -text "No additional axis in position 1"
goto -label END_LABEL

########################################
# External axes in pos 1 System 04 Start
########################################
#EXTAXPOS1C
echo -text "Installing config for Ext Ax C pos 1"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_7C_DM1.cfg -domain MOC
goto -label EXTAXPOS2_LABEL
#EXTAXPOS1T
echo -text "Installing config for Ext Ax T pos 1"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_7T_DM1.cfg -domain MOC
goto -label EXTAXPOS2_LABEL
#EXTAXPOS1U
echo -text "Installing config for Ext Ax U pos 1"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_7U_DM1.cfg -domain MOC
goto -label EXTAXPOS2_LABEL
#EXTAXPOS1W_LOW
echo -text "Installing config for Ext Ax W pos 1"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_7W_LOW_DM1.cfg -domain MOC
goto -label EXTAXPOS2_LABEL
#EXTAXPOS1W_HIGH
echo -text "Installing config for Ext Ax W pos 1"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_7W_HIGH_DM1.cfg -domain MOC
goto -label EXTAXPOS2_LABEL
#EXTAXPOS1W_262V
echo -text "Installing config for Ext Ax W pos 1"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_7W_262V_DM1.cfg -domain MOC
goto -label EXTAXPOS2_LABEL
########################################
# External axes in pos 1 System 04 End
########################################

########################################
# External axes in pos 1 System 09 Start
########################################

# IRC5 Compact 1-phase
#ADU1_790A_ER1
echo -text "Installing config for Additional Rectifier (ARU-430A, 1-Phase)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_ARU430C_430_P2_1PH_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_ARU430C_430_P2_1PH_DM1.cfg.enc -domain MOC -internal
echo -text "Installing config for Ext Ax pos 1 (1-Phase)"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M7_ER_1PH_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS2_LABEL

# Small & medium robots
#ADU1_790A_ER2
echo -text "Installing config for Additional Rectifier (ARU-430A)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_ARU430A_430_P2_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_ARU430A_430_P2_DM1.cfg.enc -domain MOC -internal
echo -text "Installing config for Ext Ax pos 1"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M7_ER_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS2_LABEL

# Small & medium robots 1-phase
#ADU1_790A_ER3
echo -text "Installing config for Additional Rectifier (ARU-430A 1-Phase)"
config -filename  $BOOTPATH/drvcfg/INT_RECTIFIER_ARU430A_430_P2_1PH_DM1.cfg -domain MOC -internal
config -filename  $BOOTPATH/drvcfg/SEC_RECTIFIER_ARU430A_430_P2_1PH_DM1.cfg.enc -domain MOC -internal
echo -text "Installing config for Ext Ax pos 1 (1-Phase)"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M7_ER_1PH_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS2_LABEL

# Large robots
#ADU1_790A_IR1
echo -text "Installing config for Ext Ax pos 1"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M7_IR_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS2_LABEL
#ADU1_790A_IR2
echo -text "Installing config for Ext Ax pos 1"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_790_M7_IR_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS2_LABEL
########################################
# External axes in pos 1 System 09 End
########################################

########################
# Drive unit external 2
########################
#EXTAXPOS2_LABEL
setvar -var 10 -value 0
getkey -id "ExtAx1Pos2Select" -var 10 -strvar $ANSWER -errlabel END_LABEL
goto -strvar $ANSWER

#EXTAXPOS2NN
echo -text "No additional axis in position 2"
goto -label END_LABEL

########################################
# External axes in pos 2 System 04 Start
########################################
#EXTAXPOS2C
echo -text "Installing config for Ext Ax C pos 2"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_8C_DM1.cfg -domain MOC
goto -label EXTAXPOS3_LABEL
#EXTAXPOS2T
echo -text "Installing config for Ext Ax T pos 2"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_8T_DM1.cfg -domain MOC
goto -label EXTAXPOS3_LABEL
#EXTAXPOS2U         
echo -text "Installing config for Ext Ax U pos 2"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_8U_DM1.cfg -domain MOC
goto -label EXTAXPOS3_LABEL
#EXTAXPOS2W_LOW
echo -text "Installing config for Ext Ax W pos 2"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_8W_LOW_DM1.cfg -domain MOC
goto -label END_LABEL
#EXTAXPOS2W_HIGH
echo -text "Installing config for Ext Ax W pos 2"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_8W_HIGH_DM1.cfg -domain MOC
goto -label END_LABEL
#EXTAXPOS2W_262V
echo -text "Installing config for Ext Ax W pos 2"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_8W_262V_DM1.cfg -domain MOC
goto -label END_LABEL
########################################
# External axes in pos 2 System 04 End
########################################


########################################
# External axes in pos 2 System 09 Start
########################################

# Small & medium robots (1-phase)
#ADU2_790A_ER1
echo -text "Installing config for Ext Ax pos 2 (1-Phase)"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M8_ER_1PH_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS3_LABEL

# Small & medium robots
#ADU2_790A_ER2
echo -text "Installing config for Ext Ax pos 2"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M8_ER_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS3_LABEL

# Large robots
#ADU2_790A_IR1
echo -text "Installing config for Ext Ax pos 2"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M8_IR_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS3_LABEL
#ADU2_790A_IR2
echo -text "Installing config for Ext Ax pos 2"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_790_M8_IR_DM1.cfg -domain MOC -internal
goto -label EXTAXPOS3_LABEL
########################################
# External axes in pos 2 System 09 End
########################################

########################
# Drive unit external 3
########################
#EXTAXPOS3_LABEL
setvar -var 10 -value 0
getkey -id "ExtAx1Pos3Select" -var 10 -strvar $ANSWER -errlabel END_LABEL
goto -strvar $ANSWER

#EXTAXPOS3NN
echo -text "No additional axis in position 3"
goto -label END_LABEL

########################################
# External axes in pos 3 System 04 Start
########################################
#EXTAXPOS3C
echo -text "Installing config for Ext Ax C pos 3"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_9C_DM1.cfg -domain MOC
goto -label END_LABEL
#EXTAXPOS3T
echo -text "Installing config for Ext Ax T pos 3"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_9T_DM1.cfg -domain MOC
goto -label END_LABEL
#EXTAXPOS3U         
echo -text "Installing config for Ext Ax U pos 3"
config -filename  $BOOTPATH/drvcfg/EXT_DRIVE_9U_DM1.cfg -domain MOC
goto -label END_LABEL
########################################
# External axes in pos 3 System 04 End
########################################


########################################
# External axes in pos 3 System 09 Start
########################################

# Small & medium robots (1-phase)
#ADU3_790A_ER1
echo -text "Installing config for Ext Ax pos 3 (1-Phase)"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M9_ER_1PH_DM1.cfg -domain MOC -internal
goto -label END_LABEL

# Small & medium robots
#ADU3_790A_ER2
echo -text "Installing config for Ext Ax pos 3"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M9_ER_DM1.cfg -domain MOC -internal
goto -label END_LABEL

# Large robots
#ADU3_790A_IR1
echo -text "Installing config for Ext Ax pos 3"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_430_M9_IR_DM1.cfg -domain MOC -internal
goto -label END_LABEL
#ADU3_790A_IR2
echo -text "Installing config for Ext Ax pos 3"
config -filename  $BOOTPATH/drvcfg/INT_DRIVE_ADU790A_790_M9_IR_DM1.cfg -domain MOC -internal
goto -label END_LABEL
########################################
# External axes in pos 3 System 09 End
########################################


#ERROR
echo -text "Error while installing drive files"
goto -label END_LABEL
#END_LABEL

