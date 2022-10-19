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
	@docker rm -f mariadb wordpress nginx || true

remove-images: remove-containers
	docker rmi inception-mariadb inception-wordpress inception-nginx || echo "Images already erased"

remove-volumes: remove-containers
	docker volume rm inception_db inception_wp || echo "Volumes already erased"
	@sudo rm -rf /home/${USER}/data/wp || echo "No wp folder"
	@sudo rm -rf /home/${USER}/data/db || echo "No db folder"

remove-network:
	docker network rm inception_network || echo "Network already erased"

check-hosts:


clean: remove-volumes remove-network
	@sudo mv /etc/old_hosts /etc/hosts || true

fclean: clean remove-images

re: fclean all

reup: clean all
