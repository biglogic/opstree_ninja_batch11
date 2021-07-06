#!/bin/bash


Action=$1
function addLineTop {
    File_name=$1
    Line=$2
    echo $Line
    if [ -e $File_name ]; then
      sed -i "1 i $Line" $File_name
      echo "Add text $Line to top of $File_name"
    else
       echo "File $File_name not exist" 
    fi   
}

function addLineBottom { 
    #total_no_of_line=$(wc -l $File_name | awk '{print$1}')
    File_name=$1
    Line=$2
    if [ -e $File_name ]; then  
       echo "$Line" >> $File_name
       echo "Text $Line adde to file $File_name"
    else 
       echo "file not exist"
    fi        
}

function addLineAt {
    File_name=$1
    Line_no=$2
    Line=$3
    if [[ ! -z $File_name  &&  -e $File_name ]]; then    
      echo "Add text $Line At Line $Line_no "
    else 
        echo $File_name not exist
    fi    
}

function deleteLine {
    File_name=$1
    Line_no=$2
    Word=$3
    if [[ -e $File_name  ]]; then
       if [[ ! -z $Word ]];then
          sed -i ''$Line_no's/'$Word'//' $File_name 
       else
          sed -i ''$Line_no'd' $File_name
          echo "text from  Line $Line_no Removed from $File_name "
       fi  
    else 
       echo "File $File_name not Found"
    fi   
}

function insertWord {
      File_name=$1
      Word1=$2
      word2=$3
      Word_to_replace=$4
      if [[ -e $File_name  ]]; then
          sed 's/'$Word1''$word2'/'$Word_to_replace'/' $File_name
          echo " $Word_to_replace added between $Word1 and $Word "  
      else 
         echo " File $File_name not Found"  
      fi 
}


function updateAllWords {
    File_name=$1
    Find_Word=$2
    Replace=$3
    if [[ -e $File_name ]]; then
        sed -i 's/"'$Find_Word'"/'$Replace'/g' $File_name
        echo " Text $Find_word  replaced by $Replace "
    else
        echo "File $File_name not found"
    fi    
}


# function updateFirstWord {
          
# }

$Action $2 "$3" "$4" "$5"

# function addLineBottom {
     
# }

