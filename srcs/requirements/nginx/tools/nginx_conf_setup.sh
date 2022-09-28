#!/bin/bash

sed -i 's/REPLACEMEUSERLOGIN/${USER_LOGIN}/g' /etc/nginx/nginx.conf
sed -i 's/REPLACEMEWORDPRESSIP/${WP_IP}/g' /etc/nginx/nginx.conf