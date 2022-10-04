FROM debian:10.11

RUN apt update && apt install mariadb-server -y
RUN apt install -y vim

# RUN service mysql start

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools /tmp/tools

# RUN chmod 711 /tmp/tools/configs_for_debugging.sh
# RUN /tmp/tools/configs_for_debugging.sh
RUN chmod 711 /tmp/tools/init_database.sh
#RUN /tmp/tools/init_database.sh


ENTRYPOINT [ "/tmp/tools/init_database.sh"]