#!/bin/bash
#Can be modified
DIR=/<ORIGINAL_DIR>/
DEST=/<DESTINATION_DIR>/
#Static variables
set -x
MAN=CLOSE_WRITE,CLOSE

inotifywait -mr -e close_write $DIR | while read line
do
    #$line will come in the form of:
    #/$PATH/$SUB_DIRECTORY/ CLOSE_WRITE,CLOSE <FILE_NAME>
    
    #Gets <FULL_PATH_TO_DIRECTORY> aka substring of $line before CLOSE_WRITE,CLOSE
    varA=${line%$MAN*}
    #Gets <FILE_NAME> aka substring of $line after CLOSE_WRITE,CLOSE
    varB=${line#*$MAN}
    #Trims tailing whitespace of varA
    strA=$(echo -e "${varA}" | sed -e 's/[[:space:]]*$//')
    #Trims leading whitespace of varB
    strB=$(echo -e "${varB}" | sed -e 's/^[[:space:]]*//')
    #Gets <FULL_PATH_OF_SUBDIRECTORIES>
    strC=${varA:${#DIR}}
    #Performs the rsync from upload directory to destination directory
    rsync -avz $strA$strB $DEST$strC
done
