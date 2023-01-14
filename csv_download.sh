#!/bin/bash

# make data directory in current directory if it does not exist
if [ ! -d ./data ]; then
    mkdir ./data
fi

# open a file from argument
exec 3< $1

#if file is not empty and a csv file
if [ -s $1 ] && [ ${1: -4} == ".csv" ]; then
    # loop each line and  print the second column
    while read -u 3 line
    do
        #download the file from the url in the second column in the data directory
        wget -P ./data $(echo $line | cut -d ',' -f 2)
        # rename the file to the first column in the line followed by the second column and the file extension
        mv ./data/$(echo $line | cut -d ',' -f 2 | cut -d '/' -f 5) ./data/$(echo $line | cut -d ',' -f 1)_$(echo $line | cut -d ',' -f 2 | cut -d '/' -f 5 | cut -d '.' -f 2)
    done
else
    echo "File is empty or not a csv file"
fi