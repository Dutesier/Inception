#!/bin/bash

sed -i "s/REPLACEMEUSERLOGIN/$USER_LOGIN/g" /etc/nginx/sites-available/wordpress;
sed -i "s/REPLACEMEWORDPRESSNAME/$WP_NAME/g" /etc/nginx/sites-available/wordpress;
sed -i "s/REPLACEMEWORDPRESSIP/$WP_IP/g" /etc/nginx/sites-available/wordpress;

ln -sf /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/wordpress;
unlink /etc/nginx/sites-enabled/default;
chown -R www-data:www-data /var/www/html;

nginx -g "daemon off;"