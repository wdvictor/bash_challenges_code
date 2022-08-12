#!/bin/bash

## Read n lines, the input will be a single character
## If the character is Y or y then echo to STDOUT YES
## If the character is N or n then echo to STDOUT NO
## If none of this, exit program

while read line
do
	if [[ $line =~ [^YyNn] ]]; then
		exit 0
	fi
	if [[ $line =~ [Yy] ]]; then
		echo "YES"
	else
		echo "NO"
	fi
done


## Here we do the same, but reading from a file ( < $1 )
while read line
do
	if [[ $line =~ [^YyNn] ]]; then
		exit 0
	fi
	if [[ $line =~ [Yy] ]]; then
		echo "YES"
	else
		echo "NO"
	fi
done < "$1"
