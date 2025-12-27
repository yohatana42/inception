FROM	debian:bookworm

ENV	DEBIAN_FRONTEND=noninteractive

RUN	apt-get update && \
	apt-get install -y --no-install-recommends \
	nginx \
	openssl && \
	service nginx start

COPY	nginx.conf /etc/nginx/nginx.conf
# COPY	index.html /var/www/html/index.nginx-debian.html
COPY	setup.sh /setup.sh
RUN		chmod +x /setup.sh

EXPOSE 443

CMD ["/setup.sh"]


# 起動してローカルホストで見てみる
# docker build -t dockerdemo .
# docker run -d -p 8080:80 --name nginx-container -it dockerdemo /bin/bash
# なんでコレで動く？しかもコンテナは立たない…？
# docker run -d -p 8080:80 -v "$(pwd)/src:/usr/share/nginx/html" dockerdemo:latest
# http://localhost:8080
# docker stop
# docker image rm

# miss!!
# docker run -d -p 8080:80 --name nginx-container -it dockerdemo /bin/bash
# docker run -it dockerdemo -d -v $(pwd)/src:/usr/share/nginx/html -p 80:80 dockerdemo:latest
