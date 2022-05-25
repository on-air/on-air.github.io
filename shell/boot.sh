#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y aptitude expect curl git zip unzip rar unrar gnupg nginx nginx-extras mysql-server net-tools fail2ban

wget -P /tmp/ https://cd.netizen.ninja/shell/npc.sh
sudo chmod +x /tmp/npc.sh
sudo cp /tmp/npc.sh /usr/bin/npc

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g pm2
sudo npm install -g @vue/cli

sudo ufw allow http
sudo ufw allow https
sudo ufw reload
