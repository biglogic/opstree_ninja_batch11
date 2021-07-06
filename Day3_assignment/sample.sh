#!/bin/bash

source  ~/$1

   
   for i in $LOGPATH/$process/*   
   do 
        value=${i##*/}
        if [[ ${value##*.} != gz ]]
        then 
            File_size=$(ls -hlk $LOGPATH/$process/${i##*/} | awk '{print$5}' | tr "K" " ") 
            #echo $File_size  
            if [ ${File_size%.*} -gt $SIZE_Threshold ]; then
               count=0          
               for j in $LOGPATH/$process/*
               do 
                  if [ "${value##.*}$count.gz" ==  "${j##*/}" ]; then 
                     count=$((count+=1))
                     echo *\n
                  fi
               done
               if [ $ACTION  == 'Backup' ]; then
                   gzip  -cvf "$LOGPATH/$process/${value##.*}" > "$LOGPATH/$process/${value##.*}$count.gz"
                   if [  $? == 0 ]; then
                        echo "{  gzip at : `date +" %D %H:%M:%S"` , File exceed Threshold : $SIZE_Threshold , LOGFILE : ${i##*/}}" >> /var/log/otcleanup/otlogcleaner.log
                        echo " " > $LOGPATH/$process/${i##*/}
                        echo #############backup done 
                   else 
                         echo "{  gzip at : `date +" %D %H:%M:%S"` , File exceed Threshold : $SIZE_Threshold , ERROR }" >> /var/log/otcleanup/otlogcleaner.log 
                         
                   fi       
               fi
               if [ $ACTION  == 'Deleted' ]; then
                    echo "{ Deleted at : `date +" %D %H:%M:%S"` , LOGFILE : ${i##*/}" >> /var/log/otcleanup/otlogcleaner.log      
                    echo " " > $LOGPATH/$process/${i##*/}
                    echo ###############DELETED
               fi
            else 
              echo "{ No_action_taken : `date +" %D %H:%M:%S"` , LOGFILE : ${i##*/} }" >> /var/log/otcleanup/otlogcleaner.log 
            fi 
                     
         fi           
   done