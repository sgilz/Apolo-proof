#!/bin/bash

nmap -sP $1 > red.txt

while IFS= read -r line; do
    if [[ $line == *"hosts"* ]]; then
	echo "$line"
    fi
done < red.txt

rm red.txt
