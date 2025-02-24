# inception

A project about setting up a set of services usign Docker, writing Dockerfiles from scratch.

## General requirements

- Follow a specified folder structure
- Provide a Makefile with specified rules
- Use docker compose

## Services

Each service must be it own dockerfile

- NGINX with TLSv1.2 or TLSv1.3
- WordPress + PHP-FPM
- MariaDB
- Redis Cache
- FTP Server (vsftpd)
- Adminer
- Extra service (Mailhod)
