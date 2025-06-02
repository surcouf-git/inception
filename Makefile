COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = $(HOME)/data

.PHONY: all build up down clean fclean re

all: build up

build:
	mkdir -p ${HOME}/data $(DATA_DIR)/wordpress $(DATA_DIR)/mariadb
	cd srcs && docker compose build

up:
	cd srcs && docker compose up

down:
	cd srcs && docker compose down

clean: down
	cd srcs && docker compose down -v
	docker system prune -f

fclean: clean
	sudo rm -rf $(DATA_DIR)
	docker system prune -af

re: fclean all
