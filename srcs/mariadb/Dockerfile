FROM	debian:bookworm

ENV	DEBIAN_FRONTEND=noninteractive

RUN	apt-get update && \
	apt-get install -y --no-install-recommends \
	mariadb-server \
	mariadb-client \
	ca-certificates && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/lib/mysql/*

RUN	mkdir -p /run/mysqld /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY	99-inception.conf /etc/mysql/mariadb.conf.d/99-inception.conf
COPY	entrypoint.sh /entrypoint.sh
RUN		chmod +x /entrypoint.sh

EXPOSE	3306

ENTRYPOINT	["/entrypoint.sh"]

# ログイン
# docker build -t mariadb .
# docker run --name mariadb -e MYSQL_ROOT_PASSWORD=password -dp 3307:3306 mariadb
# docker exec -it mariadb /bin/bash
# mariadb -p
# password
