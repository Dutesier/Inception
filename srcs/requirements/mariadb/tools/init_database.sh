#!/bin/bash
mysql_install_db;
# Make sure mariadb is on
service mysql start

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then

    # Enforce password usage
    mysql -e "UPDATE mysql.user SET Password = PASSWORD('$DB_ROOT_PASSWORD') WHERE User = 'root';"

    # Drop anonymous users
    mysql -e "DROP USER IF EXISTS ''@'localhost';"
    mysql -e "DROP USER IF EXISTS ''@'$(hostname)';"

    # Drop test database
    mysql -e "DROP DATABASE IF EXISTS test;"

    # Create wordpress database
    mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

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
    mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
    mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"

    mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
    mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"

    mysql -e "FLUSH PRIVILEGES;"

fi

service mysql stop
mysqld