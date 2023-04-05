# Inception

> **_NOTE:_**  This project could be way more simply done using pre-built Docker images, such as the ones found on Docker Hub. That would however take away from the learning experience.

## Setting up:
- [ ] A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
- [ ] A Docker container that contains WordPress + php-fpm (it must be installed and
configured) only without nginx.
- [ ] A Docker container that contains MariaDB only without nginx.
- [ ] A volume that contains a WordPress database.
- [ ] A second volume that contains the WordPress website files.
- [ ] A docker-network that establishes the connection between the containers.

## Setup
Clone the repository
cd setup
./setup.sh
cd ..
configure you .env file (USE YOUR USER!)
make