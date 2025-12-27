#!/bin/bash

set -euo pipefail

echo "= setup mariaDB ="

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# dbの構築
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "= db init ="
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	echo ""
	echo "create db user"
	/usr/sbin/mysqld --user=mysql --datadir=/var/lib/mysql & pid="$!"

	echo "waiting for mariaDB..."
	for i in {30..0}; do
		if mysqladmin ping --silent 2>/dev/null; then
			echo "mariaDB is waking up"
			break
		fi
		echo "waiting..."
		sleep 1
	done

	if [ "$i" = 0 ]; then
		echo "Error: mariaDB failed to start"
		exit 1
	fi

	echo ""
	echo "=== create database ==="
	mysql <<-EOSQL
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

		CREATE DATBASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

		-- create user and password for wordpress
		CREATE DATBASE IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
		GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

		-- crete user and password for localhost
		CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
		GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'localhost';

		FLUSH PRIVILEGES;
	EOSQL

	mysqladmin shutdown -p"${MYSQL_ROOT_PASSWORD}" 2>/dev/null || kill -s TERM "$pid"
	wait "$pid" 2>/dev/null || true
	echo "= setup complete ="

else
	echo "database already initialized."
fi

echo "== start mariaDB =="
exec /usr/sbin/mysqld --user=mysql
