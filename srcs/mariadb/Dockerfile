FROM mariadb:latest

COPY ./init.sql /docker-entrypoint-initdb.d/

VOLUME ["/var/lib/mysql"]


# FROM debian:bookworm

# ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && \
# 	apt-get install -y --no-install-recommends \
# 	mariadb-server \
# 	mariadb-client \
# 	ca-certificates && \
# 	rm -rf /var/lib/apt/lists/* && \
# 	rm -rf /var/lib/mysql/*

# RUN mkdir -p /run/mysqld /var/lib/mysql && \
# 	chown -R mysql:mysql /run/mysqld /var/lib/mysql

# COPY conf/99-inception.conf /etc/mysql/mariadb.conf.d/99-inception.conf
# COPY tools/entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# EXPOSE 3306

# ENTRYPOINT ["/entrypoint.sh"]

# docker build -t mariadb .
# docker run --name mariadb -e MYSQL_ROOT_PASSWORD=password -dp 3307:3306 mariadb
