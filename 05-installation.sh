#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "please run this script as root user"
    exit 1
else
    echo "You are running this dcript as root user"

dnf install mysql -y

if [ $? -eq 0 ]; then
    echo "mysql installed successfully"
    exit 0
else
    echo "mysql installation failed"
    exit 1
fi 