#Loop over all languages and call $BOOTPATH/language/install.cmd

getkey -id "LangSelect" -var 5 -strvar $CURRLANG -errlabel END_OF_LOOP
getkey -id "LanguageDesc" -var 5 -strvar $CURRDESC -errlabel NO_DESC
goto -strvar $CURRLANG

#NO_DESC
setstr -strvar $CURRDESC -value "$CURRLANG"
goto -strvar $CURRLANG

#END_OF_LOOP
setvar -var 7 -value 0

#For backwards compability - set $LANG to primary language before exiting loop
setvar -var 5 -value 0
getkey -id "LangSelect" -var 5 -strvar $CURRLANG -errlabel ENGLISH

goto -strvar $CURRLANG

#DANISH
ifstr -strvar $LANG -value "da" -label NO_INSTALL
setstr -strvar $LANG -value "da"
goto -label INST_LANG
#DUTCH
ifstr -strvar $LANG -value "nl" -label NO_INSTALL
setstr -strvar $LANG -value "nl"
goto -label INST_LANG
#CZECH
ifstr -strvar $LANG -value "cs" -label NO_INSTALL
setstr -strvar $LANG -value "cs"
goto -label INST_LANG
#ENGLISH
ifstr -strvar $LANG -value "en" -label NO_INSTALL
setstr -strvar $LANG -value "en"
goto -label INST_LANG
#FINNISH
ifstr -strvar $LANG -value "fi" -label NO_INSTALL
setstr -strvar $LANG -value "fi"
goto -label INST_LANG
#FRENCH
ifstr -strvar $LANG -value "fr" -label NO_INSTALL
setstr -strvar $LANG -value "fr"
goto -label INST_LANG
#GERMAN
ifstr -strvar $LANG -value "de" -label NO_INSTALL
setstr -strvar $LANG -value "de"
goto -label INST_LANG
#HUNGARIAN
ifstr -strvar $LANG -value "hu" -label NO_INSTALL
setstr -strvar $LANG -value "hu"
goto -label INST_LANG
#ITALIAN
ifstr -strvar $LANG -value "it" -label NO_INSTALL
setstr -strvar $LANG -value "it"
goto -label INST_LANG
#JAPANESE
ifstr -strvar $LANG -value "ja" -label NO_INSTALL
setstr -strvar $LANG -value "ja"
goto -label INST_LANG
#PORTUGUESE
ifstr -strvar $LANG -value "pt" -label NO_INSTALL
setstr -strvar $LANG -value "pt"
goto -label INST_LANG
#SPANISH
ifstr -strvar $LANG -value "es" -label NO_INSTALL
setstr -strvar $LANG -value "es"
goto -label INST_LANG
#SWEDISH
ifstr -strvar $LANG -value "sv" -label NO_INSTALL
setstr -strvar $LANG -value "sv"
goto -label INST_LANG
#CHINESE
ifstr -strvar $LANG -value "zh" -label NO_INSTALL
setstr -strvar $LANG -value "zh"
goto -label INST_LANG
#KOREAN
ifstr -strvar $LANG -value "ko" -label NO_INSTALL
setstr -strvar $LANG -value "ko"
goto -label INST_LANG
#RUSSIAN
ifstr -strvar $LANG -value "ru" -label NO_INSTALL
setstr -strvar $LANG -value "ru"
goto -label INST_LANG
#TURKISH
ifstr -strvar $LANG -value "tr" -label NO_INSTALL
setstr -strvar $LANG -value "tr"
goto -label INST_LANG
#POLISH
ifstr -strvar $LANG -value "pl" -label NO_INSTALL
setstr -strvar $LANG -value "pl"
goto -label INST_LANG
#ROMANIAN
ifstr -strvar $LANG -value "ro" -label NO_INSTALL
setstr -strvar $LANG -value "ro"
goto -label INST_LANG


#INST_LANG

#End of loop - exit
if -var 7 -value 0 -label END_LABEL

echo -text "Installing $CURRDESC files"
include -path "$BOOTPATH/language/install.cmd"

#NO_INSTALL

addvar -var 5 -value 1

#END_LABEL
