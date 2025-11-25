#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f)
LOG_FILE="$LOGS_FOLDER/SCRIPT_NAME.log"


mkdir -p $LOGS_FOLDER
echo " Script started Execution at : $(date) "

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

dnf list installed mysql &>> $LOG_FILE

if [ $? -ne 0 ]; then 
    dnf install mysql -y  &>> $LOG_FILE
    VALIDATE $? "MySQL"
else 
    echo -e " MySQL is already installed ... $Y skipping $N"
fi 

dnf list installed nginx  &>> $LOG_FILE
if [ $? -ne 0 ]; then 
    dnf install nginx -y  &>> $LOG_FILE
    VALIDATE $? "Nginx"
else 
    echo -e " Ngnix is already installeed ... $Y skipping $N"
fi 

# MONGOSH
dnf list installed python3  &>> $LOG_FILE
if [ $? -ne 0 ]; then 

    dnf install python3 -y  &>> $LOG_FILE
    VALIDATE $? "python3"
else
    echo -e " python3 is already installed ... $Y skipping $N"
fi
