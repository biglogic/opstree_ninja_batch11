#!/bin/bash


OPT=$1
Name_opt=$2
Server_name=$3
Host=$4
Host_Machine=$5
User=$6
Remote_user=$7
Port=$8
Port_Add=$9
key=${10}
Key_Path=${11}




function add_server {
      if [ $Name_opt == '-n' ]; then
          if [ $Host == '-h' ]; then
            check_server=$(cat ssh_list | awk -v server_name=$Server_name '{ if ($1==server_name) {print "Found" ; exit }}')
            echo $check_server
            if [ ! -z $check_server ];
            then
             echo "server alias $Server_name already in list "
            else 
             #echo "server alias $Server_name already in list " 
             add_host 
            fi 
          fi 
      fi       
      
}

function add_host {
      if [[ $Host == '-h' && ! -z $Host_Machine ]]; then
          if [[ ! -z $User && $User == '-u' ]]; then 
              add_user
              echo " add Host $Host_Machine"
              sleep 2s
          else
             echo "[ERROR] USER REQUIRED "
          fi   
      fi                
}
 

function add_user {
      if [ ! -z $Remote_user ]; then
         if [[ ! -z  $Port  &&  $Port == '-p' ]]; then
            add_port
            echo " Add User $Remote_user"
         else 
           echo " Add User $Remote_user"
           echo " $Server_name : ssh $Remote_user@$Host_Machine " >> ssh_list
         fi      
      fi  
} 

function add_port {
     if [ ! -z $Port_Add ]; then
        if [ $key == '-i' ]; then 
        #echo " $Server_name :  ssh  -p $Port_Add   me " >> ssh_list
        #echo "added"
           add_key
           echo "Add port $Port_Add " 
        else
           echo " $Server_name : ssh -p $Port_Add  $Remote_user@$Host_Machine " >> ssh_list
        fi
      fi      

}

function add_key {
     echo " $Server_name : ssh -i $Key_Path -p $Port_Add  $Remote_user@$Host_Machine " >> ssh_list
     echo "Add Key  $Key_Path  "
     
}

function connect_server {
      v=$(cat ssh_list | awk -v server_alias=$1 '$1==server_alias {print $3,$4,$5,$6,$7,$8,$9}')
      if [[ -z $v ]]; then
         echo " [ERROR]: Server information is not available, please add sever first"
      else    
         awk '{print "Connecting to " , $1 , "on" , $5 , "port"}' ssh_list
         sleep 4s
         $v
      fi         
}

function remove {
     sed -i ''"$Server_name"'d' ssh_list
     echo " Rremove server from $Server_name list   "

}

if [ $OPT == '-a' ]
then 
     add_server
elif [ $OPT == "l" ]
then 
  if [[ ! -z $2 && $2 == '-d' ]]; then
   awk '{print$0}' ssh_list
  else
     awk '{print$1}' ssh_list
  fi    
elif [ $OPT == "Connect" ]; then 
      connect_server $2
elif [ $OPT == "rm" ]; then
       remove      
fi        