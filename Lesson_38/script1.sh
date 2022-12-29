#!/bin/bash

bucket_path="s3://astrovskiy-bucket/backups"

# Archive creation
tar -zcvf "storage_$(date '+%Y-%m-%d_%H-%M-%S').tar" ./test
mv storage_$(date '+%Y-%m-%d_%H-%M-%S').tar ./backup
echo "An archive is complited"

# Copy backup archive to aws s3 bucket
aws s3 cp backup/storage_$(date '+%Y-%m-%d_%H-%M-%S').tar $bucket_path/
echo "Copy to s3 bucket is complited"

#An assignment of variables
max_files=5
file_counter=`aws s3 ls $bucket_path/ | wc -l`

echo "Backup folder has $file_counter files"

# To remove files above a restriction
if [ $file_counter -gt $max_files ];
then
how_many_delete=$(($file_counter - $max_files))
for (( i==1; i<$how_many_delete; i++ ))
do
deleted=$(aws s3 ls $bucket_path/ | sort | head -n 1 | awk '{print $4}') 
aws s3 rm $bucket_path/$deleted
echo "$deleted - erased" >> ./backup/log.txt
done
else
echo "No files to delete"
fi
