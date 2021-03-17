#!/bin/bash

apt update
apt upgrade -y
apt install -y aptitude git curl zip unzip rar unrar gnupg nginx nginx-extras net-tools fail2ban expect
apt install -y php-fpm php-mbstring php-gettext php-mcrypt php-mysql mysql-server

mkdir /var/log/www
mkdir /var/log/www-data
rm -rf /var/www/*
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
	server_name localhost 127.0.0.1;
	root /var/www;
	index index.php;
	# access_log /var/log/www/access.log;
	# error_log /var/log/www/error.log;
	location / { try_files \$uri \$uri/ =404; }
	location ~ /\.ht { deny all; }
	location ~ \.php\$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php-fpm.sock;
		}
	}" > /etc/nginx/sites-enabled/www

wget https://raw.githubusercontent.com/on-air/on-air.github.io/master/shell/db/mysql_secure_installation.sh
chmod +x mysql_secure_installation.sh
./mysql_secure_installation.sh 'My_SQL.3306'
echo -en "CREATE USER 'master'@'%' IDENTIFIED WITH mysql_native_password BY 'My_SQL.3306';
CREATE DATABASE master;
CREATE DATABASE client;
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';" > my.sql
mysql < my.sql
mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
echo -en "[mysqld]
user = mysql
bind-address = 0.0.0.0
mysqlx-bind-address = 127.0.0.1
key_buffer_size = 16M
myisam-recover-options = BACKUP
log_error = /var/log/mysql/error.log
max_binlog_size = 100M" > /etc/mysql/mysql.conf.d/mysqld.cnf

wget https://raw.githubusercontent.com/on-air/on-air.github.io/master/shell/firewall.rule -P /tmp/
mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
cp /tmp/firewall.rule /etc/ufw/before.rules

ufw allow ssh
ufw allow http
ufw allow https
ufw allow 3306/tcp
