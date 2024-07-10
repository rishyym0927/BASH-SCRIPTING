#! /usr/bin/bash

#how to pass aruements 
echo $1 $2 $3

#lets store the arguments in an array
args=("$@")
echo ${args[0]} ${args[1]} ${args[2]}

# $0th argument is the name of the file

#to print all the arguments
echo $@

#to print the number of arguments
echo $#



