#!/bin/bash

ACTION=$1
DIR_PATH=$2
DIR_PATH2=$3
DIR_NAME=$3
FILE_NAME=$3
CONTENT=$4
LINES=$4
LINE_TO=$4

if  [ $ACTION == 'addDir' ]; then
     if [ ! -e $DIR_PATH/$DIR_NAME ]
     then
       mkdir -p $DIR_PATH/$DIR_NAME 
       echo "### created directory $DIR_PATH/$DIR_NAME "
     else
       echo "####directory Allready exist"  
     fi 
fi      


if [ $ACTION == 'listFiles' ]; then
     ls -l $DIR_PATH | grep -v "^d"


elif [ $ACTION == 'listDirs' ]; then
     cd $DIR_PATH && ls -d *


elif [ $ACTION == 'listAll' ]; then
     cd $DIR_PATH && ls 


elif [ $ACTION == 'deleteDir' ]; then
     rm -rf $DIR_PATH/$DIR_NAME
     echo "#####directory deleted $DIR_NAME"


elif [ $ACTION == 'addFile' ]; then
     touch $DIR_PATH/$FILE_NAME
     

elif [ $ACTION == 'addContentToFile' ]; then
     echo "$CONTENT" >> $DIR_PATH/$FILE_NAME
 

elif [ $ACTION == 'addContentToFileBegining' ]; then 
     sed -i '1s/^/'$CONTENT'\n/' $DIR_PATH/$FILE_NAME
     echo "#######Done######"     


elif [ $ACTION == 'showFileBeginingContent' ]; then
     head -n $LINES $DIR_PATH/$FILE_NAME


elif [ $ACTION == 'showFileEndContent' ]; then
      tail -n $LINES $DIR_PATH/$FILE_NAME 


elif [ $ACTION == 'showFileContentAtLine' ]; then
     sed -n ''$LINES'p' $DIR_PATH/$FILE_NAME
      
 

elif [ $ACTION == 'showFileContentForLineRange' ]; then
      sed -n ''$LINES'' $DIR_NAME/$FILE_NAME  


elif [ $ACTION == 'moveFile' ]; then
     mv $DIR_PATH $DIR_PATH2
     echo "####moving done"


elif  [ $ACTION == 'copyFile' ]; then
     rm $DIR_PATH/$FILE_NAME
     echo "###### DElete Done $FILE_NAME"



elif [ $ACTION == 'clearFileContent' ]; then
     if [ -e $DIR_PATH/$FILE_NAME ]
     then
        echo "" > $DIR_PATH/$FILE_NAME
        echo "#####Clear Content Done"
     else 
        echo "######not found###### $FILE_NAME"
     fi   


elif [ $ACTION == 'deleteFile' ]; then
     if [ -e $DIR_PATH/$FILE_NAME ]
     then
       rm $DIR_PATH/$FILE_NAME
       echo "#######done######## $FILE_NAME"
     else
         echo "####### not exist $FILE_NAME " 
     fi      
          

elif [ $ACTION == 'deleteDir' ]; then
     if [ -e $DIR_PATH/$DIR_NAME ]
     then 
        rm -rf $DIR_PATH/$DIR_NAME
        echo "#######File deleted $DIR_NAME "
     else 
        echo "############ Directory not found"   
     fi  
fi      



