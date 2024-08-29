FROM alpine:3.19.3

RUN apk update --no-cache && apk upgrade --no-cache
RUN apk add mariadb mariadb-client --no-cache

COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/mariadb_img_entry.sh /usr/local/bin
COPY tools/mariadb_healthcheck.sh /usr/local/bin

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && chmod +x /usr/local/bin/mariadb_img_entry.sh /usr/local/bin/mariadb_healthcheck.sh;

ENTRYPOINT ["mariadb_img_entry.sh"]
