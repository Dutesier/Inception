#!/bin/bash
sed -i "s/MYSQL_U/$MYSQL_USER/g" /var/www/html/wp-config.php;
sed -i "s/MYSQL_P/$MYSQL_PASSWORD/g" /var/www/html/wp-config.php;
sed -i "s/MYSQL_DB_H/$MYSQL_DB_HOST/g" /var/www/html/wp-config.php;
sed -i "s/MYSQL_D/$MYSQL_DATABASE/g" /var/www/html/wp-config.php;

# Give mariadb some time
while ! mariadb -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_DB_HOST $MYSQL_DATABASE; do
    sleep 2
done

# Auto install Wordpress (localhost should be changed here)
wp core install --path=/var/www/html/ --allow-root --title=inception --url="localhost" --admin_user=$DB_USER --admin_email=$USER_LOGIN"@42lisboa.student.com" 2>/tmp/wp_install.log 1>>/tmp/install.log
wp theme install --path=/var/www/html/ twentytwentytwo --activate --allow-root

# Create user
# TODO

# Create php7.3 socket
service php7.3-fpm start;
service php7.3-fpm stop;

php-fpm7.3 -R -F