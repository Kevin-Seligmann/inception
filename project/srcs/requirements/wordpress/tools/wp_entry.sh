#!bin/sh

WP_PATH=/var/www/wordpress
WP=wp-cli.phar
CLI_FLAGS="--allow-root --path=$WP_PATH"

# Wp download
$WP core download $CLI_FLAGS

# Wp config file
$WP config create $CLI_FLAGS --dbname=${WP_DATABASE_NAME} --dbuser=${WP_DATABASE_ADMIN_USERNAME} --dbpass=${WP_DATABASE_ADMIN_PASSWORD} --dbhost=mariadb

# Redis config
$WP config set WP_REDIS_HOST redis $CLI_FLAGS
$WP config set WP_REDIS_PASSWORD "['${REDIS_DATABASE_USERNAME}', '${REDIS_DATABASE_PASSWORD}']" --raw $CLI_FLAGS

# Wp install
$WP core install $CLI_FLAGS --title=${WP_TITLE} --url=${WP_URL} --admin_user=${WP_ADMIN_USERNAME} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}

# Wp user
$WP user create $CLI_FLAGS ${WP_USER_USERNAME} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD}

# Redis install
$WP plugin install redis-cache $CLI_FLAGS
$WP plugin activate redis-cache $CLI_FLAGS
$WP redis enable $CLI_FLAGS

# STMP Mailer install
$WP plugin install smtp-mailer $CLI_FLAGS
$WP plugin activate smtp-mailer $CLI_FLAGS

exec php-fpm82 -F
