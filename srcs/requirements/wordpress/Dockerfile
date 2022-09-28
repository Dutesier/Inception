FROM debian:10.11

RUN apt update
RUN apt install -y php php-fpm tar wget

RUN wget http://wordpress.org/latest.tar.gz
RUN tar xfz latest.tar.gz
RUN mkdir -p /var/www/html/
RUN mv wordpress/* /var/www/html/
RUN rm -f latest.tar.gz

COPY ./conf/wp-config.php /var/www/html/wp-config.php

CMD ["/bin/bash", "-c", "service php-fpm start; tail -f /dev/null"]
