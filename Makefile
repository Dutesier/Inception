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

	@sudo ./srcs/requirements/tools/setup_etc_hosts.sh

	docker compose $(FLAGS) build

up: build
	docker compose $(FLAGS) up --detach

down:
	docker compose $(FLAGS) down

stop:
	docker compose $(FLAGS) stop

remove-containers: stop
	@docker rm -f mariadb wordpress nginx && echo "Removed containers" || echo "Containers already removed"

remove-images: remove-containers
	@docker rmi inception-mariadb inception-wordpress inception-nginx && echo "Erased images" || echo "Images already erased"

remove-volumes: remove-containers
	@docker volume rm inception_db inception_wp && echo "Erased volumes" || echo "Volumes already erased"
	@sudo rm -rf /home/${USER}/data/wp && echo "Erased wp folder" || echo "No wp folder"
	@sudo rm -rf /home/${USER}/data/db && echo "Erased db folder" || echo "No db folder"

remove-network:
	@docker network rm inception_network && echo "Removed network" || echo "Network already erased"


clean: remove-volumes remove-network
	@sudo mv /etc/old_hosts /etc/hosts && echo "Reset /etc/hosts file to default" || true

fclean: clean remove-images

re: fclean all

reup: clean all
