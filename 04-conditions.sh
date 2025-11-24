#!/bin/bash

echo "Enter the Number:"
read NUMBER

if [ (($NUMBER%2)) -eq 0 ]; then 
    echo "The number $NUMBER is Even"
else
    echo The number $NUMBER is Odd"
fi
