FROM debian:10.11

RUN apt update ; apt install -y nginx openssl
# RUN openssl genrsa -des3 -passout pass:x -out server.pass.key 2048 && \
#     openssl rsa -passin pass:x -in server.pass.key -out server.key && \
#     rm server.pass.key && \
#     openssl req -new -key server.key -out server.csr \
#         -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com" && \
#     openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
RUN mkdir -p /etc/nginx/certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/nginx-selfsigned.key -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com" -out /etc/nginx/certs/nginx-selfsigned.crt

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
