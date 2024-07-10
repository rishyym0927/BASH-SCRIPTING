#! /usr/bin/bash

count=11

if [ $count -lt 10 ]
then
    echo "the condition is true"

elif (( $count > 9 ))
then
    echo "the number is greater than 9"
else
    echo "the condition is false"
fi 