#!/bin/bash
# Create an array with seted parameters
function arr {
n=1
ms=("$@")
for x in "${ms[@]}"
do
	echo "$n. $x"
	n=$((n+1))
done
}

#the launch of function
arr "$@"
