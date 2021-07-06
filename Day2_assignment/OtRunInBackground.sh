#!/bin/bash


ACTION=$1

if [ $ACTION == 'start' ]
then
   script_Path=$2
   ./$script_Path $3  2>pid &
   if [ $? -eq 0 ]; then
     echo service started	    
     echo  $(ps ax -o pid,%mem,%cpu,time | grep $!) >> servicestat
   else
     echo Failed
   fi     
fi

if [ $ACTION == 'stop' ]; then
	script_Path=$2
        Pid=$(ps -ef | grep $script_Path | awk '{print$2}')
        kill $Pid	
fi	



# if [ $ACTION == "stop" ]
# then 
#     if 



