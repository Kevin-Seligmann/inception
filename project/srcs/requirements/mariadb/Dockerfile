FROM alpine:3.22.2

RUN \
	apk update --no-cache \
	&& apk upgrade --no-cache \
	&& addgroup --g 1001 mysql \
	&& adduser -g -D -H -S -G mysql -u 1001 mysql \
	&& apk add mariadb mariadb-client --no-cache \
	&& mkdir -p /run/mysqld \
	&& touch /var/run/mysqld/mysqld.pid \
	&& chown mysql:mysql -R /var/run/mysqld \
	&& chmod 1777 /run/mysqld

COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/mariadb_img_entry.sh tools/mariadb_healthcheck.sh /usr/local/bin/

RUN chown mysql:mysql /usr/local/bin/mariadb_img_entry.sh /usr/local/bin/mariadb_healthcheck.sh \
    && chmod +x /usr/local/bin/mariadb_img_entry.sh /usr/local/bin/mariadb_healthcheck.sh \
	&& chown -R mysql:mysql /var/lib/mysql /run/mysqld

USER mysql

ENTRYPOINT ["mariadb_img_entry.sh"]
