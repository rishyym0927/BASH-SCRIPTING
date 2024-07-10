#! /usr/bin/bash

#to get the list of all shells -> cat /etc/shells/
#to gfind where is bash located -> which nash
#to run ./hello.sh
#to give permission -> chmod +x hello.sh
#to run -> ./hello.sh




echo  "HELLO WORLD"
#this is a comment 

#system variable predfeined by Operating System defined in capital lettersd
echo $BASH #gives you the location of bash
echo "our bash version is $BASH_VERSION"
echo "our home directory is $HOME"
echo "our current directory is $PWD"


#user defiend variables and it should not start with number
name=Mark
echo "The name is $name"

#arithemtic operations
num1=20
num2=5
echo $(( num1 + num2 ))

#taking user input 
echo "Enter name and age "
read name age
echo "The name is $name and age is $age" 

#taking input in same line
read -p "username: " user_var
echo "username is $user_var"

#taking input in hidden mode
read -sp "password: " pass_var
echo "password is $pass_var"