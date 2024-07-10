#! /usr/bin/bash


#how to use arrays
os=('ubuntu' 'windows' 'kali')
echo "${os[@]}" #to print all the elements of the array
echo "${os[0]}" #to print the first element of the array
echo "${!os[@]}" #to print the indices of the array

#to print the number of elements in the array
echo "${#os[@]}"
#to add an element to the array
os[3]='mac'

#to remove an element from the array
unset os[2]
