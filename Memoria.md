Using docker-compose.yml.

Configuration requirements
- One service, one container
- One service, one dockerfile
- Docker images have the name of the service they hold
- Containers are built from the penultimate version of debian/alpine, no other repository image is allowed
- Containers should restart on failure
- Services should run properly as PID 1
- No Latest tag
- No password should be present in dockerfiles
- Env. variables must be used with a .env. Docker secrets is recommended
- NGINX should be the only entrypoint to the network via port 443 and TLS
- Credentials should be git ignored


Services
- NGINX 
    - TLSv1.2 or TLSv1.3
- php-fpm with WordPress
- MariaDB   
- redis cache for WordPress (Bonus)
- FTP server pointing to the WordPress volume (Bonus)
- Adminer (Bonus)
- mailhog (Bonus)

Volumes
- Volumes should be inside the /home/login/data folder
- WordPress database
- WordPress website

Networks
- docker-network for containers

WordPress configuration
- Administrator user without any reference to being an administrator on its name or password
- Any other user

Other
- Domain name 'login.42.fr' pointing to the website
- Simple static website not in PHP 

README.md requirements
- On root of git repository
- First line italized should say: This project has been created as part of the 42 curriculum by <login1>[, <login2>[, <login3>[...]]]
- A "Description" section that "clearly presents the project, including its goal and a brief overview."
    - Must explain the use of Docker and the sources included on the project, main design choices and comparisons:
        - Virtual machines vs Docker
        - Secrets vs Environmnet variables
        - Docker network vs host network
        - Docker volumes vs bind mount
- A "Instructions" section containing information about compilation, instalation and execution (If it makes sense)
- A "Resources" section listing 'classic' references related to the topic. With a description of how was AI used, which tasks and parts.

USER_DOC.md requirements
- How can an end user (Administrator):
    - Understand services provided on the stack
    - Start and stop the project
    - Access the website and the administration panel
    - Locate and manage credetials
    - Check that the services are running correctly

DEV_DOC.md requirements
- How a developer can:  
    - Set up the environment from scratch (prerequisites, configuration files, secrets).
    - Build and launch the project using Makefile and Docker-compose
    - Relevant commands to manage contaners and volumes
    - Where the data is stored and how it persists

Directory structure example
Makefile
secrets
srcs

./secrets
credentials.txt
db_password.txt
...

./srcs
docker-compose.yml
.env
requirements

./srcs/requirements
bonus
mariadb
...

./srcs/requirements/mariadb
conf
Dockerfile
.dockerignore
tools
...