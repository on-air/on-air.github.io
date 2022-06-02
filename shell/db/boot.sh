#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y aptitude expect curl git zip unzip rar unrar gnupg net-tools fail2ban mysql-server

sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3306/tcp
sudo ufw reload
