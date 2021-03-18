#!/bin/bash

apt update
apt upgrade -y
apt install -y aptitude git curl zip unzip rar unrar gnupg nginx nginx-extras net-tools fail2ban expect
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
apt install -y nodejs
npm install -g pm2
npm install -g @vue/cli
# snap install core
# snap refresh core
# snap install certbot --classic
# ln -s /snap/bin/certbot /usr/bin/certbot
# snap set certbot trust-plugin-with-root=ok

mkdir /var/log/www
mkdir /var/log/www-data
rm -rf /var/www/*
mkdir /var/www/127.0.0.1
touch /var/www/127.0.0.1/index.html
mkdir /var/www/host
touch /var/www/host/index.html
rm -rf /etc/nginx/sites-available/*
rm -rf /etc/nginx/sites-enabled/*
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

echo -en "user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 768;
	# multi_accept on;
	}

http {
	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;
	server_tokens off;
	# more_set_headers \"Server: nginx\";
	server_names_hash_bucket_size 64;
	include /etc/nginx/mime.types;
	default_type application/octet-stream;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
	ssl_prefer_server_ciphers on;
	access_log /var/log/www-data/access.log;
	error_log /var/log/www-data/error.log;
	gzip on;
	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/html text/css text/xml text/javascript application/javascript application/json application/xml application/xml+rss;
	server {
		listen 80;
		listen [::]:80;
		server_name _;
		return 444;
		}
	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
	}" > /etc/nginx/nginx.conf

echo -en "server {
	listen 80;
	server_name 127.0.0.1;
	root /var/www/127.0.0.1;
	index index.html;
	# access_log /var/log/www/127.0.0.1/access.log;
	# error_log /var/log/www/127.0.0.1/error.log;
	location /ng-static/ { try_files \$uri \$uri/ =404; }
	location / { try_files \$uri \$uri/ /index.html; }
	}" > /etc/nginx/sites-enabled/127.0.0.1

echo -en "server {
	listen 80;
	server_name host *.host;
	root /var/www/host;
	index index.html;
	# access_log /var/log/www/host/access.log;
	# error_log /var/log/www/host/error.log;
	location /ng-static/ { try_files \$uri \$uri/ =404; }
	location / {
		proxy_pass http://127.0.0.1:3000;
		proxy_http_version 1.1;
		proxy_cache_bypass \$http_upgrade;
		proxy_set_header Upgrade \$http_upgrade;
		proxy_set_header Connection 'upgrade';
		proxy_set_header Host \$host;
		proxy_set_header X-Forwarded-For \$remote_addr;
		}
	}" > /etc/nginx/sites-enabled/host

wget https://raw.githubusercontent.com/on-air/on-air.github.io/master/shell/firewall.rule -P /tmp/
mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
cp /tmp/firewall.rule /etc/ufw/before.rules

ufw allow ssh
ufw allow http
ufw allow https
