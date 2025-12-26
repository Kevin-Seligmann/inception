# Services provided

## MariaDB

MariaDB is a relational database that holds the content of the WordPress website. It's crucial for providing persistent storage to the docker system, allowing the stored content to prevail independently of the lifetime of the MariaDB service.

Detailed information about the configuration can be found inside the docker-compose.yml file, and inspecting the /requirements/mariadb folder.

Credentials can be found on the .env file inside the srcs folder.

The volume content (Database) is inside the '/home/kseligma/data on development/test' folder.

The oficial mariadb documentation can be found on mariadb.com/docs

## Nginx

Nginx is a server program that provides web services. It allows the developer to configure TLS for HTTPS access. It uses fastcgi to connect with the wordpress container and serve the website.

Detailed information about the configuration can be found inside the docker-compose.yml file, and inspecting the /requirements/nginx folder.

Nginx also provides access to the adminer and mailhog services through their respectives ports.

A detailed documentation about nginx can be found on its official website nginx.org/en/docs/index.html

## php-fpm (Wordpress)

php-fpm is a FastCGI service that works as an interface between the web server and the php interpreter. This service is the one generating or providing the actual web files to the server before leaving the container system. Therefore it's most strongly associated to the Wordpress volume.

The Wordpress volume is the folder that contains the website files, located at the '/home/kseligma/data on development/test' folder.

Detailed information about the configuration can be found inside the docker-compose.yml file, and inspecting the /requirements/wordpress folder.

Credentials can be found on the .env file inside the srcs folder.

Detailed documentation about Wordpress can be found at its website wordpress.org/documentation/

# Project initialization/stopage

This sections asumes the host is configured correctly and built. If that's not the case, read the DEV_DOC.md document or contact a developer.

## Project initialization

On the root of the project, the command 'docker compose --project-directory "/project/srcs" up -d' or its alias 'make up' should start an stoped project.

## Project stopage

On the root of the project, the command '--project-directory "/project/srcs" up stop' or its alias 'make stop' should stop an ongoing project.

## Project starting (After stop)

On the root of the project, the command 'docker compose --project-directory "/project/srcs" start' or its alias 'make start' should restart the project

## Project rebuild

On the root of the project, the command 'docker compose --project-directory "/project/srcs" up --build -d' or its alias 'make rebuild' should restart the project

# Website administration

The website will be accesible through a browser via 'https://127.0.0.1:443 on development/test host' or more conveniently through a hostname 'https://login.42.fr:443 on development/test host'.

Login in with the administrator account (See Credentials administration) provides access to the admin panel at /wp-admin.php

# Credentials administration

Inside the 'srcs' folder on the root of the project, a file .env can be modified to set the credentials. To make sure to apply the changes, the project might need to be rebuilt.

WP_USER_USERNAME=...

WP_USER_PASSWORD=...

WP_USER_EMAIL=...

WP_ADMIN_USERNAME=...

WP_ADMIN_PASSWORD=...

WP_ADMIN_EMAIL=...

WP_URL=...

WP_TITLE=...

# Service administration

You can check the services are running correctly with the command 'docker compose ls'. It will list the service and you must identify the services of this application. The list of services should say that each service is 'running' or 'healthy'.

