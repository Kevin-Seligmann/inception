#!bin/sh

mysql_install_db --datadir="/var/lib/mysql"

mariadbd & MARIADB_PID=$!

for i in {25..0}; do
	if mariadb -e "SELECT '1';" &> /dev/null; then
		echo 'mariadb init started'
		break
	fi
	echo 'mariadb init starting...'
	sleep 1
done

if [ "$i" = 0 ]; then
	echo >&2 'mariadb init failed'
	exit 1
fi

# More secure installation, and to avoid anonymous user interfering with WP user on healthcheck
mariadb -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_ROOT_PASSWORD}');"
mariadb -e "DELETE FROM mysql.user WHERE User='';"
mariadb -e "DROP DATABASE IF EXISTS test;"
mariadb -e "DELETE FROM mysql.db where Db='test' OR Db='test\\_%'"
mariadb -e "FLUSH PRIVILEGES;"

# Wp database and user init
mariadb -e "CREATE DATABASE IF NOT EXISTS ${WP_DATABASE_NAME};"
mariadb -e "CREATE USER IF NOT EXISTS '${WP_DATABASE_ADMIN_USERNAME}'@'%' IDENTIFIED BY '${WP_DATABASE_ADMIN_PASSWORD}';"
mariadb -e "GRANT ALL ON ${WP_DATABASE_NAME}.* TO '${WP_DATABASE_ADMIN_USERNAME}'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

kill -s TERM "$MARIADB_PID"

wait "$MARIADB_PID"

exec mariadbd-safe
