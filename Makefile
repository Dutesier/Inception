NAME	= inception

DIR_S	= srcs
FLAGS	= -p $(NAME) -f $(DIR_S)/docker-compose.yml

all: $(NAME)

$(NAME): run

build:
	docker-compose $(FLAGS) build

run: build
	docker-compose $(FLAGS) up --detach

down:
	docker-compose $(FLAGS) down

clean:
	docker rm -f $(shell docker ps -al -q --filter name=$(NAME))
	docker network rm $(shell docker network ls -q --filter name=$(NAME))
	docker volume rm $(shell docker volume ls -q --filter name=$(NAME))

fclean: clean
	docker rmi $(shell docker images -aq)

re: fclean all