#!/bin/bash
sed -i "s/MYSQL_U/$MYSQL_USER/g" /var/www/html/wp-config.php;
sed -i "s/MYSQL_P/$MYSQL_PASSWORD/g" /var/www/html/wp-config.php;
sed -i "s/MYSQL_DB_H/$MYSQL_DB_HOST/g" /var/www/html/wp-config.php;
sed -i "s/MYSQL_D/$MYSQL_DATABASE/g" /var/www/html/wp-config.php;


service php7.3-fpm start;
tail -f /dev/null