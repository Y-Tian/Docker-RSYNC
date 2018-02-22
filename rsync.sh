#!/bin/bash
#Can be modified
WATCH_1=/<$DIR1>/
WATCH_2=/<$DIR2>/
WATCH_3=/<$DIR3>/
#Static variables
set -x
MAN=CLOSE_WRITE,CLOSE
PATTERN_1=<$DIR1>
PATTERN_2=<$DIR2>

inotifywait -mr -e close_write $WATCH_1 $WATCH_2 | while read line
do
    #$line will come in the form of:
    #<FULL_PATH_TO_DIRECTORY> CLOSE_WRITE,CLOSE <FILE_NAME>
    
    #Gets <FULL_PATH_TO_DIRECTORY> aka substring of $line before CLOSE_WRITE,CLOSE
    varA=${line%$MAN*}
    #Gets <FILE_NAME> aka substring of $line after CLOSE_WRITE,CLOSE
    varB=${line#*$MAN}
    #Trims tailing whitespace of varA
    strA=$(echo -e "${varA}" | sed -e 's/[[:space:]]*$//')
    #Trims leading whitespace of varB
    strB=$(echo -e "${varB}" | sed -e 's/^[[:space:]]*//')

    #STAGE 1: <$DIR1> -> <$DIR2>
    if [[ $strA == *"$PATTERN_1"* ]]; then
        #Gets <FULL_PATH_OF_SUBDIRECTORIES>
        strC=${varA:${#WATCH_1}}
        #Performs the rsync from upload directory to destination directory
        rsync -avz $strA$strB $WATCH_2$strC

    #STAGE 2: <$DIR2> -> <$DIR3>
    elif [[ $strA == *"$PATTERN_2"* ]]; then
        #Gets <FULL_PATH_OF_SUBDIRECTORIES>
        strC=${varA:${#WATCH_2}}
        #Performs the rsync from upload directory to destination directory
        rsync -avz $WATCH_2$strC $WATCH_3$strC
    fi
done
