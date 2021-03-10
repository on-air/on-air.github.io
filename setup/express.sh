#!/bin/bash

apt update
apt upgrade -y
apt install -y git curl zip unzip rar unrar gnupg nginx nginx-extras net-tools fail2ban
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
apt install -y nodejs
npm install -g pm2
npm install -g @vue/cli
snap install core
snap refresh core
snap install certbot --classic
ln -s /snap/bin/certbot /usr/bin/certbot
snap set certbot trust-plugin-with-root=ok

mkdir /var/log/www
mkdir /var/log/www/000-default
rm -rf /var/www/*
mkdir /var/www/000-default
touch /var/www/000-default/index.html
rm -rf /etc/nginx/sites-available/*
rm -rf /etc/nginx/sites-enabled/*

cd /tmp
wget https://on-air.github.io/setup/firewall.rule
sudo mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
sudo cp /tmp/firewall.rule /etc/ufw/before.rules
cd
