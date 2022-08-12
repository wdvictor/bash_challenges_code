#!/bin/bash


# Your task is to use for loops to display only odd natural numbers frin 1 to 99.

for i in {1..100}
do
    if [[ $(expr $i % 2) != 0 ]] then
        echo $i
    fi
done
