FROM alpine:3.15.4

RUN apk update ; apk add nginx
RUN adduser -D -g 'www' www
RUN mkdir /www
RUN chown -R www:www /www
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/ /www
RUN echo "--nginx should be setup, trying to run--"

CMD nginx -g "daemon off;"