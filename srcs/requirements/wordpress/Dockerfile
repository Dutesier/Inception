FROM debian:10.11

RUN apt update
RUN apt install -y vim
RUN apt install -y php php7.3-fpm tar wget php7.3-curl php7.3-dom php7.3-exif php7.3-mysql

RUN wget http://wordpress.org/latest.tar.gz
RUN tar xfz latest.tar.gz
RUN mkdir -p /var/www/html/
RUN touch /var/log/wp-errors.log
RUN mv wordpress/* /var/www/html/
RUN rm -f latest.tar.gz

COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./tools/replace_env.sh /tmp/replace_env.sh
RUN chmod 711 /tmp/replace_env.sh
COPY ./conf/php.ini /etc/php/7.3/fpm/php.ini
COPY ./conf/wordpress_pool.conf /etc/php/7.3/fpm/pool.d/wordpress_pool.conf



ENTRYPOINT [ "/tmp/replace_env.sh" ]
