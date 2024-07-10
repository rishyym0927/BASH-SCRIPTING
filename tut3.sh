#! /usr/bin/bash


echo -e "enter the name of file :\c"
read file_name
if [ -e $file_name ]
then
    echo "$file_name found"
else
    echo "$file_name not found"
fi

# -f flag is used to check if the file is a regular file or not
# -e flag is used to check if the file exists or not
# -d flag is used to check if the file is a directory or not
# -b flag is used to check if the file is a block special file or not
# -c flag is used to check if the file is a character special file or not
# -s flag is used to check if the file is empty or not