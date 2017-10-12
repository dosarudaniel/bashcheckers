#!/bin/bash

#This script checks if a <nr_of_runs> consecutives runs will have the same result. 

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 binary_file nr_of_runs" >&2
  exit 1
fi

file=my__result
COUNTER=$2

mkdir ./tests

until [ $COUNTER -lt 1 ]; do
	./$1 > tests/$COUNTER
	let COUNTER-=1
done

A=$COUNTER
let COUNTER-=1
B=$COUNTER

# it can be improved: when I discover two different files call "exit 1"
until [ $B -lt 1 ]; do
	diff ./tests/$A ./tests/$B >> $file # $file will be created if there are differences
	let A-=1
	let B-=1
done


if [ -f $file ]
then 
	cat $file 
	echo "You have a problem in your solution, check \"tests folder\"." 
	rm $file
else echo "You have a stable solution!" && rm -rf tests 
fi

