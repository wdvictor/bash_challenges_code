#!/bin/bash


#Given two integers X and Y, find their sum, difference, product, and quotient.

#Input format:
#Two lines containing one interger each (X and Y, respectively)

#Contrains

#-100 <= X,Y <= 100
#y != 0

#Output
#(X+Y)
#(X-Y)
#(X * Y)
#(X / Y)
#While computing the quotient, print only the integer part

read X
read Y

echo $(($X + $Y))
echo $(($X - $Y))
echo $(($X / $Y))
echo $(($X * $Y))

