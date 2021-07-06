#!/bin/bash

# sleep 5m 2>&1 &
# mkdir $BASHPID\

y='yes'

while [ $y == 'yes' ]
do 
  sleep 2s
  curl -s localhost:80 > /dev/null
  echo "{ TIME_STAMP : `date +"%H:%M:%S" ` , USER: $USER }" >> logfile
done 
