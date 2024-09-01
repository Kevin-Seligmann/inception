FROM alpine:3.19.3

RUN \
	apk update --no-cache \
	&& apk upgrade --no-cache \
	&& addgroup --g 1001 mysql \
	&& adduser -g -D -H -S -G mysql -u 1001 mysql \
	&& apk add mariadb mariadb-client --no-cache \
	&& mkdir -p /run/mysqld \
	&& chown mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/mariadb_img_entry.sh tools/mariadb_healthcheck.sh /usr/local/bin/

USER mysql

ENTRYPOINT ["mariadb_img_entry.sh"]
