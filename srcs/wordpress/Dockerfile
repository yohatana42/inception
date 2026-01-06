FROM	debian:bookworm

ENV	DEBIAN_FRONTED=noninteractive

RUN	apt-get update && \
	apt-get install -y --no-install-recommends \
		php8.2-fpm \
		php8.2-mysql \
		php8.2-curl \
		php8.2-gd \
		php8.2-mbstring \
		php8.2-xml \
		php8.2-xmlrpc \
		php8.2-zip \
		curl \
		wget  \
		ca-certificates \
		mariadb-client && \
	rm -rf /var/lib/apt/lists/*

COPY	setup.sh /setup.sh
RUN chmod +x /setup.sh

RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' /etc/php/8.2/fpm/pool.d/www.conf

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/setup.sh"]
