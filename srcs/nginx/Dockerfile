FROM	debian:bookworm

ENV	DEBIAN_FRONTEND=noninteractive

RUN	apt-get update && \
	apt-get install -y --no-install-recommends \
	nginx \
	openssl && \
	rm -rf /var/lib/apt/lists/*

COPY	nginx.conf /etc/nginx/nginx.conf
# COPY	index.html /var/www/html/index.nginx-debian.html
COPY	setup.sh /setup.sh
RUN		chmod +x /setup.sh

EXPOSE 443

CMD ["/setup.sh"]
