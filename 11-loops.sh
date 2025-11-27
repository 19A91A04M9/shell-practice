#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"


mkdir -p $LOGS_FOLDER
echo " Script started Execution at : $(date) " | tee -a $LOG_FILE

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

for package in $@ 
do
    dnf list installed $package &>> $LOG_FILE

    if [ $? -ne 0 ]; then 
        dnf install $package -y  &>> $LOG_FILE
        VALIDATE $? "$package"
    else 
        echo -e " $package is already installed ... $Y skipping $N" 
    fi
done    

