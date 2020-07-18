#!/bin/bash

show_lines(){
    INPUT_FILE=$1
    I=1
    while IFS= read -r LINE
    do
	if [ $I -ge 12 ] && [ $I -le 22 ] ; then
	    echo "$I $LINE"
	fi
	let I=$I+1
    done < $INPUT_FILE
}

if [ $# -eq 1 ]; then
    show_lines $1
else
    echo "usage: <script> <file>"
fi
