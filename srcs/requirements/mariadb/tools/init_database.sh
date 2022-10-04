#!/bin/bash
mysql_install_db;
# Make sure mariadb is on
service mysql start

# Enforce password usage
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$DB_PASSWORD') WHERE User = 'root'"

# Drop anonymous users
mysql -e "DROP USER IF EXISTS '@''localhost'"
mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"

# Drop test database
mysql -e "DROP DATABASE IF EXISTS test"

# Create wordpress database
mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME"

# Entering dummy tables and data
mysql -e "use $DB_NAME;\
    CREATE TABLE IF NOT EXISTS data \
    ( data_id INT AUTO_INCREMENT PRIMARY KEY, \
    title VARCHAR(255) NOT NULL );"

mysql -e "use $DB_NAME;\
    INSERT INTO data (title) VALUES('A');"

mysql -e "use $DB_NAME;\
    INSERT INTO data (title) VALUES('B');"

# Creating wordpress user
# mysql -e "CREATE USER IF NOT EXISTS '$DB_USER@$WORDPRESS_IP' IDENTIFIED BY '$DB_PASSWORD'"
mysql -e "CREATE USER IF NOT EXISTS '$DB_USER' IDENTIFIED BY '$DB_PASSWORD'"

# mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER@$WORDPRESS_IP'"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'"

mysql -e "FLUSH PRIVILEGES"

# Check if database doesn't already exist
if [[ ! -d "/var/lib/mysql" ]]; then
    echo "Database does not exit"
fi

mysqladmin -u root -p${DB_PASSWORD} shutdown

mysqld