#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then
    echo -e "$R Error:: Please run this script as root user $N"
    exit 1
fi 

# VALIDATE FUNCTION
VALIDATE() {
    if [ $1 -eq 0 ]; then
        echo -e " $2 installation ... $G SUCCESS $N"
    else
        echo -e " $2 installation ... $R FAILED $N"
        exit 1
    fi
}

dnf list installed mysql 

if [ $? -ne 0 ]; then 
    dnf install mysql -y
    VALIDATE $? "MySQL"
else 
    echo -e " MySQL is already installed ... $Y skipping $N"
fi 

dnf list installed nginx
if [ $? -ne 0 ]; then 
    dnf install nginx -y
    VALIDATE $? "Nginx"
else 
    echo -e " Ngnix is already installeed ... $Y skipping $N"
fi 

# MONGOSH
dnf list installed python3
if [ $? -ne 0 ]; then 

    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo -e " python3 is already installed ... $Y skipping $N"
fi
