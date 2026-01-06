COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/yohatana/DATA_PATH

all: build up

build:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@docker compose -f $(COMPOSE_FILE) build --no-cache

up:
	@docker compose -f $(COMPOSE_FILE) up --build -d

down:
	@docker compose -f $(COMPOSE_FILE) down

ps:
	@docker compose -f $(COMPOSE_FILE) ps

clean:
	@docker system prune -f

fclean:
	@docker system prune -af --volumes
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*

re: fclean all

.PHONY: all build up down clean fclean re ps
