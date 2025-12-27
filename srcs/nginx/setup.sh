#!/bin/bash

echo "== setup nginx =="
mkdir -p /etc/nginx/ssl

echo "create public key for nginx"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=JP/ST=Tokyo/L=Shinjuku/O=42/OU=Inception/CN=yohatana.42.fr"

echo "start nginx..."
# バックグラウンド処理だと終了後コンテナが落ちる
nginx -g 'daemon off;'
