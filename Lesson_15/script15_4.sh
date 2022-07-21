#!/bin/bash
#Programm loop
while true
echo "Choose a script which you want to launch
(type a number of script) 
1. script_1 (multiplying numbers)
2. script_2 (a folder check)
3. script_3 (an array structure)"
echo "your choice is:"

do
read script

#Conditions for script 1
if [ $script -eq 1 ]
then
	echo "type two numders (for example: 1 3 )"
	read s1
	./script15_1.sh $s1
	
else
	echo "You should type a number of script"
	echo	
			
fi

#Conditions for script 2
if [ $script -eq 2 ]
then
	./script15_2.sh
		
fi

#Conditions for script 1
if [ $script -eq 3 ]
then
	echo "type something to put it into the array"
	read s2
	./script15_3.sh $s2
fi

#Repeat loop or end it
echo
echo "Try once more time? (y/n)"
read answer
if [ $answer == "y" ]
then
continue
elif [ $answer == "n" ]
then
	echo "Goodbuy!"
	break
else
	echo "I tend to suggest that it means "no", so Goodbuy!"
	break
fi
done
			
