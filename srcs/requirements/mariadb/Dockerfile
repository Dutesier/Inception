FROM debian:10.11

# Install mariadb server
RUN apt update && apt install mariadb-server -y

# Copy mariadb config files
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy tools for mariadb setup
COPY ./tools /tmp/tools
RUN chmod 711 /tmp/tools/init_database.sh

# Run script to create users and innitialize a database
ENTRYPOINT [ "/tmp/tools/init_database.sh"]