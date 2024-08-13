#
# Default mask for Moc
uprobe_set_mask -func statma_set_moc_uprobe_level -domain ipol_start -mask 1
# Default mask for Rol
uprobe_set_mask -func rol_dbg_setlevel -mask 0
# Default mask for Cir
uprobe_set_mask -func sdlog_set_level -mask 0 -arg -1
# Default mask for Cap
uprobe_set_mask -func caplog_set -mask 0 -arg -1
# Default mask for Eio
uprobe_set_mask -func eio_trace -mask 0
