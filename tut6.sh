#! /usr/bin/bash

#different types fopr loops

#1. for loop
for i in 1 2 3 4 5
do
    echo $i
done

#2. for loop to print the numbers from 1 to 10
for i in {0..10}
do
    echo $i
done

#3. for loop to print the numbers from 1 to 10 with a step of 2
for i in {0..10..2}
do
    echo $i
done

#4. for loop to print the numbers from 10 to 0
for (( i=10; i>=0; i-- ))
do
    echo $i
done


#5. for loop to print the numbers from 10 to 0 with a step of 2
for (( i=10; i>=0; i-=2 ))

do
    echo $i
done

#6 for loops with command

for command in ls pwd date
do
    echo "-----------------$command-----------------"
    $command
done

#7. for loop to print the files in the current directory

for item in *
do
    if [ -f $item ]
    then
        echo $item
    fi
done