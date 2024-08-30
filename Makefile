PROJECT_DIR = srcs
PROJECT_DATA_ROOT = /home/kseligma/data/
WORDPRESS_DIR = wordpress
MARIADB_DIR = mariadb

all: data_dir up

data_dir:
	mkdir -p $(PROJECT_DATA_ROOT)$(WORDPRESS_DIR) $(PROJECT_DATA_ROOT)$(MARIADB_DIR)

start:
	docker compose --project-directory $(PROJECT_DIR) start

stop:
	docker compose --project-directory $(PROJECT_DIR) stop

up:
	docker compose --project-directory $(PROJECT_DIR) up -d

rebuild: stop
	docker compose --project-directory $(PROJECT_DIR) up --build -d

rm_container: stop
	-docker container rm $$(sudo docker container ls -a -q)

rm_image:
	-docker image rm $$(sudo docker image ls -a -q)

rm_data:
	rm -rf $(PROJECT_DATA_ROOT)*

fclean: rm_container rm_image rm_data
	docker system prune -f -a

re: fclean all

.PHONY: all data_dir start stop up rebuild rm_container rm_image rm_data fclean re
