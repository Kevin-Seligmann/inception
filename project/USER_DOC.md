# Instructions for the administrator

## Services provided

### MariaDB

MariaDB is a relational database that holds the content of the WordPress website. It's crucial for providing persistent storage to the docker system, allowing the stored content to prevail independently of the lifetime of the MariaDB service.

Detailed information about the configuration can be found inside the docker-compose.yml file, and inspecting the /requirements/mariadb folder.

Credentials can be found on the .env file inside the srcs folder.

The volume content (Database) is inside the '/home/kseligma/data on development/test' folder.

The oficial mariadb documentation can be found on mariadb.com/docs

### Nginx

Nginx is a server program that provides web services. It allows the developer to configure TLS for HTTPS access. It uses fastcgi to connect with the wordpress container and serve the website.

Detailed information about the configuration can be found inside the docker-compose.yml file, and inspecting the /requirements/nginx folder.

Nginx also provides access to the adminer and mailhog services through their respectives ports.

A detailed documentation about nginx can be found on its official website nginx.org/en/docs/index.html

### php-fpm (Wordpress)

php-fpm is a FastCGI service that works as an interface between the web server and the php interpreter. This service is the one generating or providing the actual web files to the server before leaving the container system. Therefore it's most strongly associated to the Wordpress volume.

The Wordpress volume is the folder that contains the website files, located at the '/home/kseligma/data on development/test' folder.

Detailed information about the configuration can be found inside the docker-compose.yml file, and inspecting the /requirements/wordpress folder.

Credentials can be found on the .env file inside the srcs folder.

Detailed documentation about Wordpress can be found at its website wordpress.org/documentation/

### Redis

Redis is a in-memory database. It's a non-relational model whose adventage is being faster than relational databases, while consuming system memory. It's used to provide a cache service to the wordpress website, allowing for fast access to cached data.

This service, while being optional, is useful to optizime the time expended on regular database queries and allowing for a better website experience.

### Adminer

Adminer is an administration panel for databases, it works as a website built in PHP and served on a configured port (/adminer.php ???). 

The access credentials can be found on the .env file inside the srcs folder, those are the MariaDB user credentials.

It's not recommended to access as an end-user/administrator. It's adviced to modify data through the wordpress website or contact a developer.

### Vsftpd

Vsftpd is a FTP deamon (Service) used to transfer or download files from the server. It's useful to transfer data to the wordpress site like images, videos, documents, etc.

A FTP client is necessary to consume the service through the exposed port.

Detailed information can be found on the docker-compose file or it dockerfile folder.

### Mailhog

LA VERDAD ES QUE NO ME ACUERDO :)

## Project initialization/stopage

This sections asumes the host is configured correctly and built. If that's not the case, read the DEV_DOC.md document or contact a developer.

### Project initialization

On the root of the project, the command 'docker compose up' or its alias 'make up' should start an stoped project.

### Project stopage

On the root of the project, the command 'docker compose down' or its alias 'make down' should stop an ongoing project.

### Project restart

On the root of the project, the command 'docker compose restart' or its alias 'make restart' should restart the project

## Website administration

The website will be accesible through a browser via IP '127.0.0.1:443 on development/test host' or more conveniently through a hostname 'kseligma.42.fr:443 on development/test host'.

Login in with the administrator account (See Credentials administration) provides access to the admin panel at /admin ????????/

Login in with the mariadb credentials, it's possible to access the adminer panel at /adminer.php???. It's recommended to use the help of a developer if any change is necessary through this method.

## Credentials administration

Inside the 'srcs' folder on the root of the project, a file .env can be modified to set the credentials. To make sure to apply the changes, the project might need to be rebuilt.

- Credential 1 ...
- Credential 2 ...

## Service administration

CREO QUE ES 'DOCKER COMPOSE LS', PERO TESTEAR INSTALADO
