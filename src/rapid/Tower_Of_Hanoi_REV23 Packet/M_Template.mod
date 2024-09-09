MODULE M_Template
    !    !*****************************************************
    !    !Module Name:   M_TEMPLATE
    !    !Version:       1.22
    !    !Description:   Program Template
    !    !Date:          2024-08-22
    !    !Author:        @ManicZanic
    !    !               
    !    !*****************************************************
    !    !Change Log:
    !    !2024-08-22:    @ManicZanic - Orignal core structure developed
    !    !                           - Added Task specific Bool data
    !    !2024-08-22:    @ManicZanic - Set VersionID to match other modules
    !    !*****************************************************
    
    LOCAL PERS bool bTemplateMenu:=TRUE;
    CONST jointtarget jTemplatePos:=[[0,0,0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    
    PROC R_Template_Menu()
        VAR num nMenuOption;!sets menu options
        VAR btnres btnresMainMenu;!Records button value
        
        !Sets the number of selectable items shown in the list view. Increasing / decreasing the number within {} will allow you to increase or decrease the number of options shown in the list 
        CONST Listitem ListOptions{7}:=[["","Case 1 description"],["","Case 2 description"],["","Case 3 description"],["","Case 4 description"],["","Case 5 description"],["","Case 6 description"],["","Case 7 description"]];

        bTemplateMenu:=True;
        WHILE bTemplateMenu DO
            nMenuOption:=UIListView(\Result:=btnresMainMenu\Header:="Enter Header Here",ListOptions\Buttons:=btnOKCancel\Icon:=iconInfo);
            IF btnresMainMenu=resCancel return ;!When Cancel button pressed this returns you to previous menu
            TEST nMenuOption
            CASE 1:
                !Place Code for List item 1 here
                !Multiple calls can be made in a single case
                !If progam is large it is recommended to create a separate template
                !MoveAbsJ jTemplatePos,v500,fine,tool0; !Will move the robot to the template home position
                !R_Template !Will call the R_Template Procedure
                !RETURN; instruction will return to this menu once task is complete
            CASE 2:
                !Place Code for List item 2 here
            CASE 3:
                !Place Code for List item 3 here
            CASE 4:
                !Place Code for List item 4 here
            CASE 5:
                !Place Code for List item 5 here
            CASE 6:
                !Place Code for List item 6 here
            CASE 7:
                !Place Code for List item 7 here
                bTemplateMenu:=False;
            ENDTEST
        ENDWHILE
        bTemplateMenu:=True;
    ENDPROC
    
PROC R_Template()
    !PLACE CODE HERE
ENDPROC

    
    
ENDMODULE