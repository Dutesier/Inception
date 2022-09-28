FROM debian:10.11

RUN apt update && apt install mariadb-server -y
RUN service mysql start

COPY ./conf /tmp/conf
COPY ./tools /tmp/tools

# RUN chmod 711 /tmp/tools/configs_for_debugging.sh
# RUN /tmp/tools/configs_for_debugging.sh
RUN chmod 711 /tmp/tools/init_database.sh
RUN /tmp/tools/init_database.sh


CMD tail -f /dev/null