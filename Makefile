NAME = inception

COMPOSE_FILE = ./srcs/docker-compose.yml
ENV_FILE = ./srcs/.env

RED = \033[0;31m
GREEN = \033[0;32m
RESET = \033[0m


all: checker folder up

checker:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "$(RED)Error: .env not found!$(RESET)"; \
		exit 1; \
	fi


folder:
	@mkdir -p $(HOME)/data/mariadb
	@mkdir -p $(HOME)/data/wordpress
	@echo "$(GREEN)--Data Folders Created--$(RESET)"

up:
	@docker compose -f $(COMPOSE_FILE) up --build -d

down:
	@docker compose -f $(COMPOSE_FILE) down


clean: down
	@docker rm $(docker ps --filter status=exited -q) 2>/dev/null || true
	@docker volume prune -f
	@echo "$(GREEN)Clean unused volumes and stopped containers!$(RESET)"

re: down up
	@echo "$(GREEN) UP UP DOWN DOWN, Elevator Operator! $(RESET)"

fclean: 
	@docker system prune -af
	@docker compose -f ${COMPOSE_FILE} down --volumes
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker rmi -f $$(docker images -q) 2>/dev/null || true
	@rm -rf $(HOME)/data/mariadb
	@rm -rf $(HOME)/data/wordpress
	@rm -rf $(HOME)/data
	@echo "$(GREEN)--COMPLETE DELETION: volumes, images and directories were removed!$(RESET)"

.PHONY: all checker folder up down clean re fclean