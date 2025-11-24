#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Error:: Please run this script as root user"
    exit 1
fi 

# VALIDATE FUNCTION
VALIDATE() {
    if [ $1 -eq 0 ]; then
        echo "$2 installation SUCCESS"
    else
        echo "$2 installation FAILED"
        exit 1
    fi
}

# MYSQL
dnf install mysql -y
VALIDATE $? "MySQL"

# NGINX
dnf install nginx -y
VALIDATE $? "Nginx"

# MONGOSH
dnf install mongodb-mongosh -y
VALIDATE $? "MongoSH"
