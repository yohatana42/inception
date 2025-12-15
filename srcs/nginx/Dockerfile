# 仮想環境の場合ubuntsuを指定
FROM 'nginx:latest'
# FROM ubuntsu:24.04

RUN service nginx start
# ここでnginxをインストールする
# RUN apt-get update && \
# 	apt-get install -y --no-install-recommends \
# 		nginx \
# 		openssl && \
# 		service nginx start

# 入力待ちでブロックされるのを防ぐ
ENV DEBIAN_FRONTEND noninteractive

# FROM NGINX:タグ名

# RUN

# COPY 設定ファイルとか移動するらしい
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/html/index.nginx-debian.html

# CMD


# 起動してローカルホストで見てみる
# docker build -t dockerdemo ./
# docker run -d -p 8080:80 -v "$(pwd)/src:/usr/share/nginx/html" dockerdemo:latest
# http://localhost:8080

# miss!!
# docker run -it dockerdemo -d -v $(pwd)/src:/usr/share/nginx/html -p 80:80 dockerdemo:latest
