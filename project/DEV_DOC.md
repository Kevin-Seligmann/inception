# Developer Guidelines

Short documentation or guidelines for the developer

## Set up the environment from scratch

### Virtual machine installation for a campus environment

These instructions are a serie of recomendations that worked at the time of writing this document.

The campus environment consists of a host machine without root access or docker, it has VirtualBox installed.

Install Debian trixie netinst iso. https://www.debian.org/download.html. When creating the virtual machine on VBOX.

When booting the installer, make sure to choose a manual installation. Most options are irrelevant or intuitive, but make sure to have all options unchecked when prompted for aditional programs except the essentials and Xfce. This desktop environment is ligther than Gnome and it's important to make sure the VM runs well on campus.

For this set of instructions, a shared folder will be created. Intra doesn't allow users to use multiple ssh keys, so the repository will be cloned on the host and managed from the guest.

To set up a shared folder, it's necessary to install VBox Guest Additions. VBox provides a menu option to insert a .iso into the VM that can be mounted and used to install the utility (At this point, should install sudo). A folder inside the host on /sgoinfre/username and the guest on /home/username with the same name can be used.

Next it's necessary to install docker and practical to add the user to a 'docker' group so it doesn't need sudo to use docker.

To edit the hostname and domain, follow the two steps and reboot:
- edit the /etc/hosts files and add:  127.0.0.1 login.42.fr login
- edit /etc/hostname with your new hostname; run sudo hostname $(cat /etc/hostname).

### Docker configuration

If docker is properly installed following the Docker documentation instructions, a folder to store the volume's data must be created. 

Using 'make dir' or running the commands

mkdir -p DATA_dIR

sudo chown 1001:1001 DATA_DIR

should set up the proper folder structure. You must also modify the Makefile to configure the proper user name for the folders.

### Environment variables

Inside the srcs folder, a .env file must be placed with the following environmental variables. The names are self-explanatory: WP_DATABASE_NAME, WP_DATABASE_ADMIN_USERNAME, WP_DATABASE_ADMIN_PASSWORD, WP_USER_USERNAME, WP_USER_PASSWORD, WP_USER_EMAIL, WP_ADMIN_USERNAME, WP_ADMIN_PASSWORD, WP_ADMIN_EMAIL, WP_URL, WP_TITLE. MARIADB_ROOT_PASSWORD

## Build and launch the project using the Makefile and Docker Compose

### User options

On the root of the project, the command 'docker compose --project-directory "/project/srcs" up -d' or its alias 'make up' should start an stoped project.

On the root of the project, the command '--project-directory "/project/srcs" up stop' or its alias 'make stop' should stop an ongoing project.

On the root of the project, the command 'docker compose --project-directory "/project/srcs" start' or its alias 'make start' should restart the project

On the root of the project, the command 'docker compose --project-directory "/project/srcs" up --build -d' or its alias 'make rebuild' should restart the project

### Developer options

make dir: Sets up the necessary folder (Provided the Makefile is configured correctly)

make rm_container: Stop the application and removes all containers (Eg to 'docker container rm $$(docker container ls -a -q)')

make rm_image: Removes all images (Eg to 'docker image rm $$(docker image ls -a -q)')

make rm_data: Removes data folders

make fclean: Executes all the remove commands (Clears project completely)

make re: Rebuild project completely 

## Use relevant commands to manage the containers and volumes

'docker compose' is the main command form which one can manage the project.

'docker compose start' - Initializes the stopped containers.

'docker compose stop' - Stop the initialized containers.

'docker compose up' - Build and starts the containers

'docker compose build' - Build the containers

'docker container ls' - Show the containers and their status

'docker compose exec'- Executes commmands inside a container (Useful for inspecting containers)

## Data persistence

The project's data is persisted through two bind mounts. It means that when the containers are stopped, the data remains in the host machine as regular data folders. 

These are the 'wordpress' folder which stores the website data, and the 'mariadb' folder which stores the mariaDB content.