#!/bin/bash

DIR_1=$1
DIR_2=$2
FILE_NAME=$(echo $DIR_2 | sed "s-.*/--")
DIRECTORY=$(echo $DIR_2 | sed "s-$FILE_NAME--")
FILE_COUNT=$(ls "$DIRECTORY" | grep -c "$FILE_NAME")
if [ $FILE_COUNT -gt 1 ]
then 
FILE_NAME=$FILE_NAME'_'$FILE_COUNT
fi
mv -f $DIR_1 $DIRECTORY$FILE_NAME