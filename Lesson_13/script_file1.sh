#!/bin/bash

mkdir -p ~/home_task13

if [ -e ~/home_task13/file1.txt ]
then
	echo "Файл file1.txt уже существует, пропуск"
else
	touch ~/home_task13/file1.txt
fi

if [ -e ~/home_task13/file2.txt ]
then
	echo "Файл file2.txt уже существует, пропуск"
else
	touch ~/home_task13/file2.txt
fi

if [ -e ~/home_task13/file3.txt ]
then
	echo "Файл file3.txt уже существует, пропуск"
else
	touch ~/home_task13/file3.txt
fi

if [ -e ~/home_task13/file4.txt ]
then
	echo "Файл file4.txt уже существует, пропуск"
else
	touch ~/home_task13/file4.txt
fi

if [ -e ~/home_task13/file5.txt ]
then
	echo "Файл file5.txt уже существует, пропуск"
else
	touch ~/home_task13/file5.txt
fi

echo "Greating to all good people!
`date`" > ~/home_task13/file1.txt
echo "two strings have been added to file1.txt"

chmod 777 ~/home_task13/file2.txt
echo "Permissions of file2.txt have been switched"

head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 > ~/home_task13/file3.txt
echo "a random string was added to file3.txt"

echo "files file4.txt and file5.txt are empty"
