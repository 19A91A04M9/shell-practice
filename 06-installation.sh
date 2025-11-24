#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Error:: please run this script as root user"
    exit 1
fi 

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo "mysql installed successfully"
        exit 0
else
        echo "mysql installation failed"
        exit 1
}

dnf install mysql -y

VALIDATE=$? "MYSQL"

dnf install nginx -y
VALIDATE=$? "nginx"
dnf install mongodb-mongosh -y
VALIDATE=$? "mongosh"
