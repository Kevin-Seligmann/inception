#!bin/sh

WP_PATH=/var/www/wordpress
WP=wp-cli.phar

$WP core download --path=$WP_PATH
$WP config create --allow-root --path=$WP_PATH --dbname=${WP_DATABASE_NAME} --dbuser=${WP_DATABASE_ADMIN_USERNAME} --dbpass=${WP_DATABASE_ADMIN_PASSWORD} --dbhost=mariadb
$WP core install --allow-root --path=$WP_PATH --title=${WP_TITLE} --url=${WP_URL} --admin_user=${WP_ADMIN_USERNAME} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email
$WP user create ${WP_USER_USERNAME} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --allow-root --path=$WP_PATH

exec php-fpm82 -F
