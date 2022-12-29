#!/bin/bash

MODE=$1
PATH_FOLDER=$2
# TODO: add second parameter for script to input the folder to backup
#PATH_FOLDER="./app"


case $MODE in
    "minutely")
        cron_schedule="* * * * *"        
        archive_name=$(date +%Y-%m-%d-%T.%7N)
        ;;
    "hourly")
        cron_schedule="1 * * * *"
        archive_name=$(date +%Y-%m-%d-%H)
        ;;
    "daily")
        cron_schedule="0 20 * * *"
        archive_name=$(date +%Y-%m-%d)
        ;;
    *)
        echo "Wrong input"
        exit 1
        ;;
esac

sudo apt install tree zip -y > /dev/null

#TODO: add variable LAUNCHER = manual \ cron, check who executed this script and write it to meta.txt
cron=$(ps -ef | grep "/usr/sbin/CRON -f" | awk '{print $2}' | head -1)

script=$(ps -ef | grep "$0 $1" | awk '{print $3}' | head -1)

if [ "$cron" -eq "$script" ]
then 
      LAUNCHER="Cron launched the script"
else
      LAUNCHER="User has launched this script"
fi

touch $PATH_FOLDER/meta.txt
whoami > $PATH_FOLDER/meta.txt
echo $LAUNCHER >> $PATH_FOLDER/meta.txt
date >> $PATH_FOLDER/meta.txt
echo "Mode: $MODE" >> $PATH_FOLDER/meta.txt



tree -a $PATH_FOLDER >> $PATH_FOLDER/meta.txt

#archivation 

zip -r ~/"$PATH_FOLDER.$archive_name".zip ~/$PATH_FOLDER

#cron
#TODO: check for active cron and dont duplicate 

if crontab -l | grep "$0" 
then
	echo "This job already exists"
else
(crontab -l 2>/dev/null; echo "$cron_schedule ~/HW16/script16.sh $1 $2") | crontab -
fi

#TODO: copying to remote
scp ~/"$PATH_FOLDER.$archive_name".zip 192.168.152.130:~/lesson16


