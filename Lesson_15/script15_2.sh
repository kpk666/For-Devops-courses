#!/bin/bash
# Import side functions for folder and files creation
source dirs_files.sh

#a folder check function
function d_list {
	if [ -d $1 ]	
	then 
		return 0
	else
		return 1
	fi		
}

#an user interaction with folders
cd ~/
echo "======================"
echo "Enter a folder name: " 
read folder

#create a recursive tree of folders
if d_list $folder
then
	cd $folder
	echo `ls -R`
else
	echo "No such directory"
fi
