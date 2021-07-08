#!/bin/bash
Google_form="/home/atul/Downloads"/'StudentMarks - Ninja assignment7 - Google form.csv'
Class6A="/home/atul/Downloads"/'StudentMarks - Ninja assignment7 - Class6A.csv'


function check_Admission_Number {
            echo "Checking Admission Number"
            echo ""           
            Sourceoftruth=$(awk -F"," 'NR==1 {next}{print$1}' "$Class6A" | sed 's/  *//')
            echo ""
            google_form=$(awk -F"," 'NR==1 {next}{print$5}' "$Google_form" |sed 's/  *//' )
            for student_id in $Sourceoftruth
            do 
                for student_id_google in $google_form
                do   
                      if [ $student_id == $student_id_google ]; then
                         check_name $student_id_google 
                        #  echo $student_id_google   
                      fi 
                done
            done                
}

function check_name {
        Name_source=`awk -v id=$1 -F"," 'NR==1 {next}{ if($1==id) print$2 }' "$Class6A"`
        Name_google=`awk -v id=$1  -F"," 'NR==1 {next}{ if($5==id) print$2 }' "$Google_form" `          
                    if [ "$Name_source" == "$Name_google" ]; then
                        # echo $name_form
                        marks=$(awk -v id="$Name_source" -F"," 'NR==1 {next}{ if($2==id) print$6 }' "$Google_form" | cut -d/ -f1)
                        Admission_id=$(awk -v id="$Name_source" -F"," 'NR==1 {next}{ if($2==id) print$5 }' "$Google_form" | cut -d/ -f1)
                        echo $marks
                        add_sheet "$Name_source" $marks $Admission_id
                    else 
                        echo "not match"
                        #check_mail    
                    fi
            
}


function check_mail {
         while read x 
         do 
            while read y
            do         
               Name_class=`echo $y | awk -F"," 'NR==1 {print$2}'`
               Name_google=`echo $x | awk -F"," 'NR==1 {print$2}'`
               if [ "$Name_class" == "$Name_google" ]; then
                    Add_id_form=`awk -v name="$Name_class" -F"," 'NR==1{next}{if($2==name){ print$1 }}' "$Google_form" | cut -d@ -f1 `
                    Add_id_Source=`awk -v name="$Name_class" -F"," 'NR==1{next}{if($2==name){ print$1 }}' "$Class6A" `
                    if [ $Add_id_form == $Add_id_Source  ]; then 
                       marks=`awk -v name="$Name_class" -F"," 'NR==1{next}{if($2==name){ print$6 }}' "$Google_form" | cut -d/ -f1 ` 
                       add_sheet "$Name_google" "$marks" $Add_id_form
                       echo "$Name_google" $Add_id_form
                    fi   
               fi      

            done < "$Class6A"    
         done < "$Google_form"     
                         
 }

 function Fail_to_authenticate {
         while read x
         do 
            name=`echo "$x" | awk -F"," '{print$2}' `
            id=`echo "$x" | awk -F"," '{print$1}' `
            add_sheet "$name" "N/A" $id
         done  < "$Class6A"  
           
 }

function add_sheet {
        echo $3
        Check_output=$(awk -v Ad_id=$3 -F","  '{ if ( $1 == Ad_id){ print "Found" ; exit}}' output.csv)
        if [ ! -z $Check_output ]; then
           echo "id already exist $3"
        else 
           awk -v name="$1" -v marks=$2 -F"," 'NR==1{next}{if($2==name){ print$1","$2","marks }}' "$Class6A" >> output.csv 
        fi  
}



check_Admission_Number
check_mail
Fail_to_authenticate

# content="$( awk 'NR==1{next}{print$0}' $Google_form | sed 's/  *//')"
# content2="$(awk 'NR==1 {next}{print$0}' "/home/atul/Downloads/"'StudentMarks - Ninja assignment7 - Class6A.csv' | sed 's/  *//')"
# for i in $content
# do 
#    for j in $content2
#    do 
#         echo $i   

#       echo $j
#    done    
# done   

