FROM debian:10.11

RUN apt update ; apt install -y nginx

# RUN groupadd www-data
# RUN useradd -g www-data www-data


# COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginx_conf_setup.sh /tmp/nginx_conf_setup.sh
RUN chmod 711 /tmp/nginx_conf_setup.sh
COPY ./conf/wordpress.conf /etc/nginx/sites-available/wordpress

# COPY ./tools/ /www
RUN echo "--nginx should be setup, trying to run--"

# CMD nginx -g "daemon off;"
CMD ["/bin/bash", "/tmp/nginx_conf_setup.sh"]
