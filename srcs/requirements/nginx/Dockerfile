FROM debian:10.11

RUN apt update ; apt install -y nginx

RUN groupadd wordpress_user
RUN useradd -g wordpress_user wordpress_user


COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginx_conf_setup.sh /tmp/nginx_conf_setup.sh
RUN chmod 711 /tmp/nginx_conf_setup.sh
RUN /tmp/nginx_conf_setup.sh
COPY ./conf/wordpress_pool.conf /etc/php/7.3/fpm/pool.d/wordpress_pool.conf
# COPY ./conf/wordpress.conf /etc/nginx/sites-available/wordpress.conf
# COPY ./conf/php.ini /etc/php/7.3/fpm/php.ini
# RUN ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled

# COPY ./tools/ /www
RUN echo "--nginx should be setup, trying to run--"

CMD nginx -g "daemon off;"