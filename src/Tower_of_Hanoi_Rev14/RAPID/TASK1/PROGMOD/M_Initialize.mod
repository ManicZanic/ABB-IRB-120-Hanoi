MODULE M_Initialize
    PERS c_disk nominal_disk :=[6.35,[0,0,0,"","",""],40,[0,0,0,"","",""]];
    
    PROC initialize_disk (c_disk disk)
        nominal_disk.height_props.max := 100;
        nominal_disk.height_props.min := 0;
        nominal_disk.height_props.sig_figs := 2;
        nominal_disk.height_props.units := "mm";
        nominal_disk.height_props.header := "Update Nominal Disc Height (Metric)";
        nominal_disk.height_props.message := "Enter Nominal Disc Height (mm)";
        
        nominal_disk.height_props.max := 1000;
        nominal_disk.height_props.min := 0;
        nominal_disk.height_props.sig_figs := 2;
        nominal_disk.height_props.units := "mm";
        nominal_disk.height_props.header := "Update Nominal Disc Diameter (Metric)";
        nominal_disk.height_props.message := "Enter Nominal Disc Diameter (mm) Of Largest Dics In The Stack";
        
        num_props_MENU nominal_disk.height, nominal_disk.height_props;
        num_props_MENU nominal_disk.diameter, nominal_disk.diameter_props;
    ENDPROC
    
ENDMODULE