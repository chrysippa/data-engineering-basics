#! /bin/bash
# A script using command-line arguments, input redirection, and interactive user input
# Greets the user and creates a file for them

# Check that user provided name as argument; if not, quit
if [[ $# != 1 ]]
then
  echo "Usage: createfile.sh your_name"
  exit
fi

name=$1

echo "Welcome, $name"

echo -n "Enter a file name for your text file: "

read filename

touch $filename.txt

echo "Surprise content!" >> $filename.txt

echo "A text file has been created with the name $filename. Check its contents!"