#!bin/sh

WP_PATH=/var/www/wordpress
WP=wp-cli.phar
CLI_FLAGS="--allow-root --path=$WP_PATH"

$WP core download $CLI_FLAGS
$WP config create $CLI_FLAGS --dbname=${WP_DATABASE_NAME} --dbuser=${WP_DATABASE_ADMIN_USERNAME} --dbpass=${WP_DATABASE_ADMIN_PASSWORD} --dbhost=mariadb
$WP plugin install redis-cache $CLI_FLAGS
$WP plugin activate redis-cache $CLI_FLAGS
$WP redis set WP_REDIS_HOST redis $CLI_FLAGS
#$WP redis enable $CLI_FLAGS
#$Wp redis status $CLI_FLAGS
$WP core install $CLI_FLAGS --title=${WP_TITLE} --url=${WP_URL} --admin_user=${WP_ADMIN_USERNAME} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email
$WP user create $CLI_FLAGS ${WP_USER_USERNAME} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD}

exec php-fpm82 -F
