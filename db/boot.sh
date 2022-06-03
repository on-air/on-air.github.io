#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y aptitude expect curl git zip unzip rar unrar gnupg net-tools fail2ban mysql-server

wget -P /tmp/ https://cd.netizen.ninja/shell/npc.sh
sudo chmod +x /tmp/npc.sh
sudo cp /tmp/npc.sh /usr/bin/npc
sudo npc setup

sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3306/tcp
sudo ufw reload
