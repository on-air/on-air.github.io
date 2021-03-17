#!/bin/bash

apt update
apt upgrade -y
apt install -y aptitude git curl zip unzip rar unrar gnupg nginx nginx-extras net-tools fail2ban expect
apt install -y php-fpm php-mbstring php-gettext php-mysql mysql-server

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
	server_name localhost 127.0.0.1 $1;
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
sudo chmod +x mysql_secure_installation.sh
sudo ./mysql_secure_installation.sh '$2'
echo -en "CREATE USER 'master'@'%' IDENTIFIED WITH mysql_native_password BY '$2';
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

wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.zip -P /tmp/
unzip /tmp/phpMyAdmin-5.1.0-all-languages.zip -d /tmp/
rm -rf /var/www/*
cp -r /tmp/phpMyAdmin-5.1.0-all-languages/* /var/www/

mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
echo -en "*filter
:ufw-before-input - [0:0]
:ufw-before-output - [0:0]
:ufw-before-forward - [0:0]
:ufw-not-local - [0:0]
-A ufw-before-input -i lo -j ACCEPT
-A ufw-before-output -o lo -j ACCEPT
-A ufw-before-input -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A ufw-before-output -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A ufw-before-forward -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A ufw-before-input -m conntrack --ctstate INVALID -j ufw-logging-deny
-A ufw-before-input -m conntrack --ctstate INVALID -j DROP
-A ufw-before-input -p icmp --icmp-type destination-unreachable -j DROP
-A ufw-before-input -p icmp --icmp-type time-exceeded -j DROP
-A ufw-before-input -p icmp --icmp-type parameter-problem -j DROP
-A ufw-before-input -p icmp --icmp-type echo-request -j DROP
-A ufw-before-forward -p icmp --icmp-type destination-unreachable -j DROP
-A ufw-before-forward -p icmp --icmp-type time-exceeded -j DROP
-A ufw-before-forward -p icmp --icmp-type parameter-problem -j DROP
-A ufw-before-forward -p icmp --icmp-type echo-request -j DROP
-A ufw-before-input -p udp --sport 67 --dport 68 -j ACCEPT
-A ufw-before-input -j ufw-not-local
-A ufw-not-local -m addrtype --dst-type LOCAL -j RETURN
-A ufw-not-local -m addrtype --dst-type MULTICAST -j RETURN
-A ufw-not-local -m addrtype --dst-type BROADCAST -j RETURN
-A ufw-not-local -m limit --limit 3/min --limit-burst 10 -j ufw-logging-deny
-A ufw-not-local -j DROP
-A ufw-before-input -p udp -d 224.0.0.251 --dport 5353 -j ACCEPT
-A ufw-before-input -p udp -d 239.255.255.250 --dport 1900 -j ACCEPT
COMMIT" > /etc/ufw/before.rules

ufw allow ssh
ufw allow http
ufw allow https
ufw allow 3306/tcp
