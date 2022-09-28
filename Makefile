NAME	= inception

DIR_S	= srcs
FLAGS	= -p $(NAME) -f $(DIR_S)/docker-compose.yml

all: $(NAME)

$(NAME): run

build:
	docker compose $(FLAGS) build

run: build
	docker compose $(FLAGS) up --detach

down:
	docker compose $(FLAGS) down

stop:
	docker compose $(FLAGS) stop

clean: stop
	docker rm -f $(shell docker ps -al -q --filter name=$(NAME)) || echo removed container from $(NAME)
	docker network rm $(shell docker network ls -q --filter name=$(NAME)) || echo removed network from $(NAME)
	docker volume rm $(shell docker volume ls -q --filter name=$(NAME)) || echo removed volume from $(NAME)

fclean: clean
	docker system prune -af

re: fclean all
