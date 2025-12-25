#!/bin/sh

args="-u root -p${MARIADB_ROOT_PASSWORD} -e"

# Install (Would do nothing if installed)
mariadb-install-db --datadir="/var/lib/mysql" --auth-root-authentication-method=normal --skip-test-db --verbose	

# Mariadb auxiliary process to execute initalization script
mariadbd & MARIADB_PID=$!

# Checking until it has started, or leave.
for i in {25..0}; do
	if mariadb $args "SELECT '1';" &> /dev/null; then
		echo 'mariadb init started'
		break
	fi
	if mariadb -u root -e "SELECT '1';" &> /dev/null; then
		echo 'mariadb init started'
		break
	fi
	sleep 1
done

if [ "$i" = 0 ]; then
	echo >&2 'mariadb init failed'
	exit 1
fi

mariadb -u root -e "SET PASSWORD FOR 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('${MARIADB_ROOT_PASSWORD}'); FLUSH PRIVILEGES;"
echo "0. Setting root password " $? 

# Changing root password after installation (Would do nothing if installed)
mariadb $args "SET PASSWORD FOR 'root'@'127.0.0.1' IDENTIFIED VIA mysql_native_password USING PASSWORD('${MARIADB_ROOT_PASSWORD}');"
echo "1. Setting root password " $? 

mariadb $args "SET PASSWORD FOR 'root'@'::1' IDENTIFIED VIA mysql_native_password USING PASSWORD('${MARIADB_ROOT_PASSWORD}');"
echo "2. Setting root password " $? 

# An user like 'root'@hostname is created
mariadb $args "SET PASSWORD FOR 'root'@'${HOSTNAME}' IDENTIFIED VIA mysql_native_password USING PASSWORD('${MARIADB_ROOT_PASSWORD}');"
echo "3. Setting root password " $? " " ${HOSTNAME} 

mariadb $args "FLUSH PRIVILEGES;"

# Creating wordpress database and user (Would do nothing if created)
mariadb $args "CREATE DATABASE IF NOT EXISTS ${WP_DATABASE_NAME};"
echo "Creating database if not exists " ${WP_DATABASE_NAME} ": " $? 

mariadb $args "CREATE USER IF NOT EXISTS '${WP_DATABASE_ADMIN_USERNAME}'@'%' IDENTIFIED VIA mysql_native_password USING PASSWORD('${WP_DATABASE_ADMIN_PASSWORD}');"
echo "Creating WP User " ${WP_DATABASE_ADMIN_USERNAME} ": " $? 

mariadb $args "GRANT ALL ON ${WP_DATABASE_NAME}.* TO '${WP_DATABASE_ADMIN_USERNAME}'@'%' WITH GRANT OPTION;"
echo "Granting WP User " ${WP_DATABASE_ADMIN_USERNAME} ": " $? 

mariadb $args "FLUSH PRIVILEGES;"

# Kill auxiliary process
kill -s TERM "$MARIADB_PID"

wait "$MARIADB_PID"

# Execute mariadb
cd '/usr' 

exec /usr/bin/mariadbd-safe --datadir='/var/lib/mysql'