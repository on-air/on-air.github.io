#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y aptitude expect curl git zip unzip rar unrar gnupg mysql-server net-tools fail2ban

wget -P /tmp/ https://cd.netizen.ninja/shell/npc.sh
sudo chmod +x /tmp/npc.sh
sudo cp /tmp/npc.sh /usr/bin/npc

sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3306/tcp
sudo ufw reload
