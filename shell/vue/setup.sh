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
mkdir /var/www/$1
touch /var/www/$1/index.html
rm -rf /etc/nginx/sites-available/*
rm -rf /etc/nginx/sites-enabled/*
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

echo -en "user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
\tworker_connections 768;
\t# multi_accept on;
\t}

http {
\tsendfile on;
\ttcp_nopush on;
\ttcp_nodelay on;
\tkeepalive_timeout 65;
\ttypes_hash_max_size 2048;
\tserver_tokens off;
\t# more_set_headers \"Server: nginx\";
\tserver_names_hash_bucket_size 64;
\tinclude /etc/nginx/mime.types;
\tdefault_type application/octet-stream;
\tssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
\tssl_prefer_server_ciphers on;
\taccess_log /var/log/www-data/access.log;
\terror_log /var/log/www-data/error.log;
\tgzip on;
\t# gzip_vary on;
\t# gzip_proxied any;
\t# gzip_comp_level 6;
\t# gzip_buffers 16 8k;
\t# gzip_http_version 1.1;
\t# gzip_types text/plain text/html text/css text/xml text/javascript application/javascript application/json application/xml application/xml+rss;
\tserver {
\t\tlisten 80;
\t\tlisten [::]:80;
\t\tserver_name _;
\t\treturn 444;
\t\t}
\tinclude /etc/nginx/conf.d/*.conf;
\tinclude /etc/nginx/sites-enabled/*;
\t}" > /etc/nginx/nginx.conf

echo -en "server {
\tlisten 80;
\tserver_name 127.0.0.1;
\troot /var/www/127.0.0.1;
\tindex index.html;
\t# access_log /var/log/www/127.0.0.1/access.log;
\t# error_log /var/log/www/127.0.0.1/error.log;
\tlocation /ng-static/ { try_files \$uri \$uri/ =404; }
\tlocation / { try_files \$uri \$uri/ /index.html; }
\t}" > /etc/nginx/sites-enabled/127.0.0.1

echo -en "server {
\tlisten 80;
\tserver_name $1 *.$1;
\troot /var/www/$1;
\tindex index.html;
\t# access_log /var/log/www/$1/access.log;
\t# error_log /var/log/www/$1/error.log;
\tlocation /ng-static/ { try_files \$uri \$uri/ =404; }
\tlocation / {
\t\tproxy_pass http://127.0.0.1:3000;
\t\tproxy_http_version 1.1;
\t\tproxy_cache_bypass \$http_upgrade;
\t\tproxy_set_header Upgrade \$http_upgrade;
\t\tproxy_set_header Connection 'upgrade';
\t\tproxy_set_header Host \$host;
\t\tproxy_set_header X-Forwarded-For \$remote_addr;
\t\t}
\t}" > /etc/nginx/sites-enabled/$1

wget https://raw.githubusercontent.com/on-air/on-air.github.io/master/shell/firewall.rule -P /tmp/
mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
cp /tmp/firewall.rule /etc/ufw/before.rules

ufw allow ssh
ufw allow http
ufw allow https
