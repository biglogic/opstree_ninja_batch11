#!/bin/bash

ACTION=$1

if [[ -n $ACTION ]]
then
  if [ $ACTION == 'topProcess' ]
  then 
      RANGE=$2
      OPT=$3 
      if [ $OPT == 'memory'  ]
      then
        ps -o pid,%mem,cmd  ax   | sort -n -r -k 2 | head -n$RANGE | awk -F"/" 'NR==1 {print "   pid  %mem " ; next}   {print$1}'
      elif [ $OPT == 'cpu' ]
      then
        echo $OPT 
        ps -o pid,%cpu,cmd  ax   | sort -n -r -k 2 | head -n$RANGE | awk -F"/" 'NR==1 {print "   pid  %cpu " ; next}   {print$1}'
      fi 
  fi

  if [ $ACTION == 'RunningDurationProcess' ]
  then
      if [[ $2 =~ [0-9] ]]
      then 
      ps -o cmd,etime= -p $2
      else 
        ps -o cmd,etime= -p $(pidof $2)
      fi   
  fi          

                                      
  if [ $ACTION == 'listOrphanProcess' ] #pending
  then 
      ps -aux | awk 'NR==1 {print "USER  PID  STAT " ; next}{ if ($8 == "Z") print $1, $2, $8 }'  
  fi  

  if [ $ACTION == 'listZoombieProcess' ]
  then 
      ps -aux | awk 'NR==1 {print "USER  PID  STAT " ; next}{ if ($8 == "Z+") print $1, $2, $8 }' 
  fi  

  if [ $ACTION == 'killProcess' ]
  then 
      PID=$2
      PROC_NAME=$2
      if [[ $PID =~ [0-9] ]]
      then  
        kill $PID
      else 
          kill -9 $(pidof $PROC_NAME) 
          if [ $?  -ne 0 ]
          then
            echo "$PROC_NAME not found"
          fi   
          
      fi    
  fi  

  if [ $ACTION == 'ListWaitingProcess' ]
  then 
      ps -au | awk '{ if ($8 == "D") print$0 }' 
  fi 

  if [ $ACTION == 'killLeastPriorityProcess' ]
  then 
      kill $(ps -e -l  | sort -n -k7 | head -n1 | awk '{print$4}')
  fi 
fi
