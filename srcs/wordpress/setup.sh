#!/bin/bash

set -e

echo "= setup wordpress ="

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_editor_password)

until mysqladmin ping -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --silent 2>/dev/null; do
	echo "waiting for mariaDB..."
	sleep 3
done
echo "mariaDB is ready"

if [ ! -f /var/www/html/wp-config.php ]; then

	cd /var/www/html

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	if [ ! -f wp-cli.phar ]; then
		echo "Error: failed to download wp-cli.phar"
		exit 1
	fi

	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	if ! command -v wp &> /dev/null; then
		echo "Error: wp commnad not found"
		exit 1
	fi

	wp core download --allow-root

	echo "creating wp config..."
	# create wp-config
	wp config create \
		--dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=mariadb \
		--allow-root
	echo "wp-config.php created"

	echo "initalizing wordpress..."
	wp core install \
		--url=${DOMAIN_NAME} \
		--title="iniception wordpress" \
		--admin_user=${WP_ADMIN_USER} \
		--admin_password=${WP_ADMIN_PASSWORD} \
		--admin_email=${WP_ADMIN_EMAIL} \
		--allow-root

	echo "create regular user..."
	wp user create \
		${WP_USER} \
		${WP_USER_EMAIL} \
		--user-pass=${WP_USER_PASSWORD} \
		--role=editor \
		--allow-root
	echo "regular user created"

else
	echo "wordpress already installed"
fi

echo "== start php =="
exec php-fpm8.2 -F
