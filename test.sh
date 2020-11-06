#!/bin/bash



### DISPLAY HELP ##
Help(){
	   
   echo "gitChecker detect updates in you repository and apply action in proyect"
   echo
   echo "Syntax: ./gitChecker.sh [-b|h|v|V]"
   echo "options:"
   echo "-b 'branch'    Branc name to check updates. 	[DEFAULT:main]" 
   echo "-p 'path'   	Path of repository folder. 		[DEFAULT:..]"
   echo "-u 'update'   	Update time in minutes			[DEFAULT:10]"
   echo "-h     		Print this Help."
   echo
	exit 0
}


### GET PARAMETERS
while getopts "b:p:u:h" options;
do
    case $options in
        b) BRANCH=${OPTARG};;
        p) GIT_PATH=${OPTARG};;
        u) UPDATE_TIME=${OPTARG};;
		h) Help;;
    esac
done
echo "Username: $username";
echo "Age: $age";
echo "Full Name: $fullname";
exit

