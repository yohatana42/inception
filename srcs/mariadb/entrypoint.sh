#!/bin/bash

set -euo pipefail

echo "= start ="

# パスワードを控える　後で使う？
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

# これはなに
mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# dbの構築がはじまる
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "= db init ="
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	echo ""
