mariadb -u ${WP_DATABASE_ADMIN_USERNAME} -p${WP_DATABASE_ADMIN_PASSWORD} -e "USE ${WP_DATABASE_NAME}" || exit 1
