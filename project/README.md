*This project has been created as part of the 42 curriculum by Kseligma*

# Description

This project is about configuring a minimal wordpress site using Docker. It has a mariaDB, php-fpm and nginx container that should be build from a docker-compose file.

The project has several restrictions imposed to further the developer's understanding of Docker and system management. It's not allowed to use repository images except alpine/debian, which means that all the Dockerfiles must configure the services properly from minimal images. It enforces correct usage of secrets/env variables. It instruct students to have proper PID 1 behavior. Etc.

It recommends certain folder structure where a Makefile is placed on top of the project, a srcs folder contains the docker-compose file, and each service is placed inside its own subfolder where it's build from.

# Instructions

To build this project, one must follow the following requirements:
- Having a credentials file '.env' properly configured in the srcs folder
- Having a volume folder in /home/login/data
- Having a system properly configured with internet, docker, a graphical interface (Recommended), etc
- login.42.fr must be the hostname of the machine (Recommended as per project instructions)

To build the project, one might use the regular 'docker compose up' command or 'make' inside the proper folder.

# Resources

These resources are aimed at the developer, they provide most of the documentation necessary to build, understand and maintain the project. A share of important information is taken from community sources (E.g stackoverflow) and AI.

## Docker resources

https://docs.docker.com/engine/install/

https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-a-container/

https://docs.docker.com/compose/

https://docs.docker.com/reference/cli/docker/

https://hub.docker.com/

## Resources of the Nginx service

https://nginx.org/en/docs/

## Resources of the MariaDB service

https://github.com/MariaDB/mariadb-docker

https://mariadb.com/docs

## Resources of the php-fpm service

https://www.php.net/docs.php


## Wordpress resources

https://wp-cli.org
https://wordpress.org/documentation/


section listing 'classic' references related to the topic. With a description of how was AI used, which tasks and parts.


 explain the use of Docker and the sources included on the project, main design choices and comparisons:

        - Virtual machines vs Docker
        - Secrets vs Environmnet variables
        - Docker network vs host network
        - Docker volumes vs bind mount

## AI Disclaimer 

Artificial intelligence has been used on this project. To make sure AI doesn't impair the learning process and the developer's understanding of the work, it's important to use the tool responsibly.

AI has been used as a last resort tool to fix bugs or edit subtle configuration options that are often difficult to notice. In other words, to provide knowledge about very specific points of the built project. Most of the knowledge has been obtained reading official documentation, and the project has been built without over-using AI. 

All information obtained from AI has been checked against updated sources and/or the knowledge of the community. 

No suggestion from AI has been implemented without reflection and critical thinking.

This is an example of AI usage on this project:

Developer: Hey, I got this error on the mariaDB container 'ERROR 2002 (HY000): Can't connect to local server through socket '/run/mysqld/mysqld.sock' (2)'. It's not very descriptive and the solutions I found on internet don't seem to work.

AI: This is a list of possible causes and solutions ... 

Developer: After reading your response and researching about the MariaDB authentication process, I agree the file might not exists at the point I execute some commands. I will check MariaDB has properly created the file before executing the commands on the entry point script.

# Project Description

Docker is a tool used to deploy automated applications from a group of configuration files. These files also act as a version control system and a portability tool. It works by handling a system of images (Layers of a virtualized container) and containers (Isolated software that runs independently of the host machine). 

Out of the scope of this project, docker is even a more powerful tool capable of deploying full applications or services from cloud repositories. 

Nginx is the server chosen as an entry point to the network. Nginx is capable of serving Wordpress through CGI and force TLS secure connections. In a more developed project, we could use Nginx as an access to FTP or Adminer. All of that can be done in a single configuration file that is proper for the scope of this project, which makes it a great choice.

Wordpress is a CMS, it connects several parts of the project: Nginx, MariaDB, .env variables or secrets, etc. It provides an opportunity to test all containers are running and a base for a small website to demonstrate. It uses php-fpm, a daemon that connects Nginx (Or any CGI user) to a PHP interpreter, serving the processed files from the Wordpress web structure to the Nginx service and then the front end client.

MariaDB is an open source relational database system that integrates well with Wordpress. It's based on MySQL, it's very well documented, fast and secure. These points make it a good choice to use on this project.


## Virtual Machines vs Docker

The main technical difference is that virtual machines run simulating a real computer and installing an OS on top of it, while Docker runs on the host machine as an isolated part of it using linux tools.

Following from that description, it turns out Docker and Virtual machines have a different series of configuration processes and tools. You run Docker writing Dockerfiles or a docker-compose, using images from the cloud and setting up different services that interact with each other through the Docker network or volumes. Virtual machines are configured managing options related to the simulated machine, which is not a concern on Docker.

But the most important difference is its usage. Docker is a tool made to deploy applications in a automated, isolated, secure manner. Different teams of developers can work on the same environment set up from a configuration file. These files can be shared and updated to the cloud creating an ecosystem where it's much easier to develop and maintain applications.

## Secrets vs Environment Variables

Environment Variables are key-value pairs accesible to the containers. They are used as a tool to share sensitive data from the host machine to the Docker containers (E.g: A password). The host's source can be specified inside the docker-compose file. Docker executes the container with the content of the file (E.g: .env) as environment variables, making them accessible to the initialization scripts and running daemons. This has the problem that the sensitive data could be exposed if the system is not properly configured. (Easy example: You provide SSH access to a container and they execute the 'env' command.). Or they can be printed on logs where unauthorized users could read them. On the contrary, managing .env files is easier than docker secrets and it's secure enough for the scope of this project.

Secrets are more secure in the sense that they are private to the containers that uses them. Each secret has to be created and asigned to each container (Or through the docker-compose file, specifying a ENV variable or file). The secret could, for example, be removed from the container after a successful initialization (Do I really need to store the Wordpress admin password on the container after the website has been successful created?). Secrets are stored in the /run/secrets/<secret_name> file inside the container.


## Docker Network vs Host Network

The host network is that of the machine running the containers. Since Docker is built inside the host machine, all traffic to the internet has to pass through the host network. It's important to remember this fact, since the host machine network could obstruct the application's usage (For example, by setting up a firewall). Nonetheless, the host network should be configured to provide a secure environment possible to run Docker.

The Docker network is a network set up by the Docker daemon. Many different networks can be created and be isolated from each other. But the main selling point of the Docker network is that containers can communicate with each other through their host names (The service name). This property allows the developer to set up an application through a server like Nginx, configuring the access to all other services through it independently of the host machine.


## Docker Volumes vs Bind Mounts

The main difference is volumes are created by Docker and are not mean to be directly accesible to the developer. In exchange, volumes isolated from the funcionality of the host machine, and Docker provide several CLI tools to manage volumes, including the option to create or restore backups. It's usually faster, doesn't increase the volume of containers, and it's usually recommended.

Bind mounts allows the developer to mount an already existing folder inside the guest. This sets the responsibility of the mount completely on the developer, which can be a good or bad thing depending of the circumstances. It provides direct access to the content from the host machine.


