#!/bin/bash
output2=$HOME/research2/sys_info.txt
output3=$HOME/research2/sys_info3.txt
criticalpath=('/etc/shadow' '/etc/passwd')


#check if research directory exists
if [ ! -d /home/sysadmin/research2 ]
then 
    mkdir /home/sysadmin/research2
else 
   echo " research2 directory exists "
fi

#check if  file exists
if [ -f $HOME/research2/sys_info.txt ]
then
  rm -r $HOME/research2/sys_info.txt
else 
  echo " file does not exist"
fi

##Create a variable output2  to hold output of command
ip addr | grep inet | tail -2 | head -1 >> $output2

##Create a variable output3 to hold output of command find
find /home -type f -perm 777 >> $output3

## using for loop to print out output of variable on each line 
output4=$(find /home -type f -perm 777)

for findfile in ${output4[@]}
 do
 echo $findfile
 done

## Create if statement to check if script was run using SUDO
if [ $UID = 0 ]
then 
 echo  " Do not run the script as root user " 
 exit
fi

##Create a for loop to print critical files permissions
for critipath in ${criticalpath[@]}
 do
    ls -la $critipath 
done


##create a for loop that check sudo abilites of each user that has home folder on the system

for user in $(ls /home)
do 
 if [ $UID != 0 ]
  then 
    echo $user $UID " User has normal access "
   else
    echo $user $UID " User has SUDO  access "
 fi
done

