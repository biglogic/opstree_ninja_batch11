#!/bin/bash
source ~/$1
count=0
function Check_name(){
    if [ -f $LOGPATH/$PROCESS/$LOGFILE ]; then
       SIZE_Threshold    #execute function
      # echo "Found file "
    else 
      echo "[ERROR] Logfile is not exist $LOGPATH/$PROCESS/$LOGFILE" >> $OtCleaner_log_Path
    fi  
}

function SIZE_Threshold(){
    File_size=$( du -h $LOGPATH/$PROCESS/$LOGFILE | awk '{print$1}' | tr 'K' ' ' )
    if [ $LOGSIZE -lt ${File_size%.*} ]
    then
       if [ $ACTION == 'Backup' ]; then
            Backup_log
           # echo "Backup"
       elif [ $ACTION == 'Deleted'  ]; then
             delete_log     
       fi 
    else
       echo "[INFO] $LOGPATH/$PROCESS/$LOGFILE Below Threshold "
    fi     
}

function Backup_log(){
        count=$((count+1))
        #echo $count   
        gzip -cf $LOGPATH/$PROCESS/$LOGFILE > $LOGPATH/$PROCESS/"$LOGFILE-`date +"%H:%M:%S"`.gz"
	echo " " > $LOGPATH/$PROCESS/$LOGFILE 
        echo "[INFO] Backup[created at `date +"%D-%H:%M:%S"` , $USER ] " >> $OtCleaner_log_Path 
}

function delete_log(){
    rm -rf $LOGPATH/$PROCESS/$LOGFILE 

}
y='yes' 
while [ $y == 'yes' ]
do
    sleep $LOG_rotate
    if [ $Backup_Count -le $count ]
    then 
       echo "[INFO] Reach Defined backups:$Backup_Count" >> $OtCleaner_log_Path
       y="no" 
    else
       Check_name
       #echo $count

    fi 
done    
