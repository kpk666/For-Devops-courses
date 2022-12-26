#!/bin/bash

# The function for folders creation
function dirs {
if [ -d ~/evidences ] && [ -d ~/evidences/act_1 ] && [ -e ~/evidences/act_2 ] && [ -e ~/evidences/act_3 ]
then
	echo "Those folders are already exist"
else
	mkdir ~/evidences ~/evidences/act_1 ~/evidences/act_2 ~/evidences/act_3
	echo "Folders have been created"
fi
}

# The function for files creation
function files {
if [ -f ~/evidences/file_1.txt ] && [ -f ~/evidences/file_2.txt ] && [ -f ~/evidences/file_3.txt ]
then
	echo "Files are already exist"
else
	touch ~/evidences/file_1.txt
	touch ~/evidences/file_2.txt
	touch ~/evidences/file_3.txt
	echo "Files have been created"
fi
}

dirs
files
