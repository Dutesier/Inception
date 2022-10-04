NAME	= inception

DIR_S	= srcs
FLAGS	= -p $(NAME) -f $(DIR_S)/docker-compose.yml

all: $(NAME)

$(NAME): up

build:
	@if [ ! -d /home/${USER}/data/wp ]; then \
		sudo mkdir -p /home/${USER}/data/wp; \
	fi

	@if [ ! -d /home/${USER}/data/db ]; then \
		sudo mkdir -p /home/${USER}/data/db ; \
	fi

	docker compose $(FLAGS) build

up: build
	docker compose $(FLAGS) up --detach

down:
	docker compose $(FLAGS) down

stop:
	docker compose $(FLAGS) stop

remove-containers: stop
	docker rm -f mariadb wordpress nginx

remove-images: remove-containers
	docker rmi inception-mariadb inception-wordpress inception-nginx

remove-volumes: remove-containers
	docker volume rm inception_db inception_wp
	@sudo rm -rf /home/${USER}/data/wp
	@sudo rm -rf /home/${USER}/data/db

remove-network:
	docker network rm inception_network

clean: remove-volumes remove-network

fclean: clean remove-images

re: fclean all

reup: clean all
