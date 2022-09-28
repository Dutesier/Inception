#!/bin/bash

# Make sure mariadb is on
# service mysql start

# Enforce password usage
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MARIADB_PASSWORD') WHERE User = 'root'"

# Drop anonymous users
mysql -e "DROP USER IF EXISTS '@''localhost'"
mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"

# Drop test database
mysql -e "DROP DATABASE IF EXISTS test"

# Create wordpress database
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress"

# Entering dummy tables and data
mysql -e "use wordpress;\
    CREATE TABLE IF NOT EXISTS data \
    ( data_id INT AUTO_INCREMENT PRIMARY KEY, \
    title VARCHAR(255) NOT NULL );"

mysql -e "use wordpress;\
    INSERT INTO data (title) VALUES('A');"

mysql -e "use wordpress;\
    INSERT INTO data (title) VALUES('B');"

# Creating wordpress user
mysql -e "CREATE USER IF NOT EXISTS '$USER_LOGIN'@'localhost IDENTIFIED BY '$MARIADB_PASSWORD'"

mysql -e "GRANT ALL PRIVILEGES IN wordpress.* to '$USER_LOGIN'@'localhost"

# Check if database doesn't already exist
if [[ ! -d "/var/lib/mysql" ]]; then
    echo "Database does not exit"
fi