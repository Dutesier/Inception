FROM debian:10.11

RUN apt update
RUN apt install -y vim curl

# Wordpress PHP recommended extensions
# https://make.wordpress.org/hosting/handbook/server-environment/

RUN apt install -y php7.3-fpm \
 php7.3-json\
 php7.3-mysql\
 php7.3-curl\
 php7.3-dom\
 php7.3-exif\
 php7.3-fileinfo\
 php7.3-common\
 php7.3-imagick\
 php7.3-mbstring\
 php7.3-xml\
 php7.3-zip\
 php7.3-cli

# Allow for sync with mariadb container
RUN apt install -y mariadb-client

# Setup debugging
RUN mkdir -p /var/www/html/
RUN touch /var/log/wp-errors.log

# Configure permissions
RUN useradd -r nginx

# Wordpress CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Setup Wordpress
RUN wp core download --allow-root --path=/var/www/html --locale="en_US"
COPY ./conf/wp-config.php /var/www/html/wp-config.php
RUN chown -R nginx:nginx /var/www/html

# Copy config files
COPY ./conf/php.ini /etc/php/7.3/fpm/php.ini
COPY ./conf/wordpress_pool.conf /etc/php/7.3/fpm/pool.d/wordpress_pool.conf

# Update env variables and start wordpress
COPY ./tools/wordpress_setup.sh /tmp/wordpress_setup.sh
RUN chmod 711 /tmp/wordpress_setup.sh
ENTRYPOINT [ "/tmp/wordpress_setup.sh" ] 