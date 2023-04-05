#!/bin/bash

Containers=('mariadb' 'nginx' 'wordpress')

# Setup a db folder
if [[ -d "/home/${USER}/data/db" ]]; then
    echo "Found /home/${USER}/data/db folder"
else
    echo "Building /home/${USER}/data/db folder"
    mkdir -p /home/${USER}/data/db
fi

# Setup a wordpress(wp) folder
if [[ -d "/home/${USER}/data/wp" ]]; then
    echo "Found /home/${USER}/data/wp folder"
else
    echo "Building /home/${USER}/data/wp folder"
    mkdir -p /home/${USER}/data/wp
fi

# Create directories for all containers
for container in ${Containers[@]}; do
    echo "Setting up $container directories"
    if [[ -d "../srcs/requirements/$container/conf" ]]; then
        echo "Found ../srcs/requirements/$container/conf"
    else
        echo "Building ../srcs/requirements/$container/conf"
        mkdir -p ../srcs/requirements/$container/conf
    fi

    if [[ -d "../srcs/requirements/$container/tools" ]]; then
        echo "Found ../srcs/requirements/$container/tools"
    else
        echo "Building ../srcs/requirements/$container/tools"
        mkdir -p ../srcs/requirements/$container/tools
    fi
done

if [[ ! -e "../srcs/.env" ]]; then
    echo "No .env file found, creating a new one"
    cp ../srcs/.env.example ../srcs/.env
    sed -i "s/USER_LOGIN=xxx/USER_LOGIN=$USER/g" ../srcs/.env
    sed -i "s/WORDPRESS_REGULAR_USER=xxx/WORDPRESS_REGULAR_USER=$USER/g" ../srcs/.env
fi