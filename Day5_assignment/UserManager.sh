#!/bin/bash

ACTION=$1


function addTeam(){
   TEAM=$2
   echo " Adding $TEAM "
   addgroup $TEAM
   if [ $? -eq 0 ]
   then 
       echo "Team Added $TEAM"
   fi	     

}

function addUser(){
	USERNAME=$2
	TEAM=$3
	echo $USERNAME
        echo "Adding User $USERNAME
              creating Home Directory /home/$USERNAME 
             " 
            useradd -d /home/$USERNAME $USERNAME
            if [ $? -eq 0 ]; then
               echo "creating Subdirectories team,ninja,all"
                usermod -G $TEAM $USERNAME      
                mkdir -p /home/$USERNAME/{team,ninja,all}
                chmod 750 /home/$USERNAME
                chown $USERNAME:$TEAM  /home/$USERNAME
		echo "same team Has full access to team"
                chown $USERNAME:$TEAM /home/$USERNAME/team && chmod 070 /home/$USERNAME/team
                echo "Ninjas have full access to ninja Deirectory"
		chown $USERNAME:$TEAM /home/$USERNAME/ninja && chmod 007 /home/$USERNAME/ninja
		echo "all users have full access to all directory"
                chown $USERNAME:$TEAM /home/$USERNAME/all && chmod 777 /home/$USERNAME/all
                echo "done"
            else
	       sleep 2s	    
	       usermod -G $TEAM $USERNAME
               echo " add user $USERNAME to team $TEAM"
            fi	    


                
}

function rmUser(){
	USERNAME=$2
	userdel $USERNAME
	if [ $? -eq 0 ]; then
	   read -p "Do you want to rm Home Directory ?" opt 
	   if [ $opt == "yes"  ]; then
		   if [ -e /home/$USERNAME ]; then
		     rm -rf /home/$USERNAME
	           fi  
           fi  
        else 
            "User not exist"
        fi 	    
          
}


$ACTION $1 $2 $3
