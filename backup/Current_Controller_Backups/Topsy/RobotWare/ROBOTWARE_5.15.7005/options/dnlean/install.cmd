# Install script for DeviceNet Lean Fieldbus 

echo -text "Installing DeviceNet Lean Fieldbus ..."
config -filename  $BOOTPATH/dnle_bus.cfg -domain EIO
append -from $BOOTPATH/dnle_opt.cmd -to $INTERNAL/opt_l0.cmd
echo -text "...done"
