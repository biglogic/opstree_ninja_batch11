#!/bin/bash

#define parameters which are passed in.
declare -A array
echo
for key in $@
do  
    array[${key%%=*}]=${key##*=} 
done 


cat  <<EOF > trainer.template
         ${array[fname]} is a trainer of ${array[Topic]}
         it is a ${array[class]} class 
EOF