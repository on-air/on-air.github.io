#!/bin/bash

apt update
apt upgrade -y
apt install -y git curl zip unzip rar unrar gnupg nginx nginx-extras net-tools fail2ban
apt install -y php-fpm php-mysql mysql-server
mysql_secure_installation
mysql

mkdir /var/log/www
mkdir /var/log/www/000-default
rm -rf /var/www/*
mkdir /var/www/000-default
touch /var/www/000-default/index.html
rm -rf /etc/nginx/sites-available/*
rm -rf /etc/nginx/sites-enabled/*

cd /tmp
apt install -y phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.zip
unzip phpMyAdmin-5.1.0-all-languages.zip
rm -rf /var/www/000-default/*
cp -r phpMyAdmin-5.1.0-all-languages/* /var/www/000-default/
cd

cd /tmp
wget https://git.netizen.ninja/shell/firewall.rule
sudo mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
sudo cp /tmp/firewall.rule /etc/ufw/before.rules
cd

sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3306/tcp
