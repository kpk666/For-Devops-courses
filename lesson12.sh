#!/bin/bash

touch ~/lesson12.txt

echo "`date`" > ~/lesson12.txt
echo 'date' >> ~/lesson12.txt
echo `date` >> ~/lesson12.txt

st="Just ordinary text"

act="$(pwd >> ~/lesson12.txt)"

sum=$( expr 13 + 12 )

echo $st $act $sum >> ~/lesson12.txt
