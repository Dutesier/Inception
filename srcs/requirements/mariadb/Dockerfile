FROM debian:10.11

RUN apt update && apt install mariadb-server -y

COPY ./conf /tmp/conf
COPY ./tools /tmp/tools

RUN chmod 711 /tmp/tools/configs_for_debugging.sh && /tmp/tools/configs_for_debugging.sh

CMD tail -f /dev/null