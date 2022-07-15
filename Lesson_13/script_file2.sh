#!/bin/bash

C=`find ~/home_task13 -type f| wc -l` 
echo "The directory home_task13 has $C files"
Perm=`find ~/home_task13 -perm 777`
echo "A file with 777 permision is $Perm"
chmod 664 $Perm
echo "Permissions were altered"
find ~/home_task13 -type f -empty -delete
echo "Empty files are detected and deleted"
D=`find ~/home_task13 -type f`
 sed -i '2,$d' $D
 echo "All strings except for first one were deteted"
