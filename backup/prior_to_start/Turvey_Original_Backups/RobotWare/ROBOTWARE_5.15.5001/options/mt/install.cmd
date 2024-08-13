###################################################
# install.cmd under the option multitask
#
# $Revision: 1.6 $
#
# DESCRIPTION:
#   Install.cmd script for Multitask
#
# MODIFICATIONS:
# $Log: install_mt.cmd,v $
# Revision 1.6  2004/04/04 19:00:55  SIGADMIN
# Patch: andah0204H11M26S18 Solved SPR: None Test status: CL Log: Added / before cir_sys_mt_cfgtext.xml;
#
# Revision 1.4  2004/04/02 09:25:12  andah
# Added / before xml-text file namn
#
# Revision 1.3  2004-02-10 14:24:31+01  andah
# Removed text files for MT. All text will be part of base ssytem
#
# Revision 1.2  2003-11-28 08:34:42+01  andah
# Configuration-rules files not installed correctly - wrong paths
#
# Revision 1.1  2003-04-23 08:16:33+02  anhe
# Added / before filename
#
# Revision 1.0  2003-03-28 16:27:28+01  anhe
# Initial revision
#
#
#
#

if -var 25 -value 10 -label END_LABEL

echo -text "Installing The Multitask option"

register -type cfgrules -domain SYS -prepath $BOOTPATH/ -postpath cir_sys_mt_cfgrules.xml
register -type cfgtext -domain SYS -prepath $BOOTPATH/language/ -postpath /cir_sys_mt_cfgtext.xml

setvar -var 25 -value 10

#END_LABEL
