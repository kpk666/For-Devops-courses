#!/bin/bash

function mult {
# even\odd check
if [ $(($1 * $2 %2)) -eq 0 ]
then
	return 0
else
	return 1
fi
}
#Interact with an option
if [ $# -eq 2 ]
then
	X=$(mult $1 $2)
	
	if mult $1 $2
	then
		echo "This number is even"
	else
		echo "This number is odd"
	fi
else
	echo "Please type two numbers"
	echo "Example script.sh 1 3"
fi

