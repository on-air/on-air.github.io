#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install -y aptitude git curl zip unzip rar unrar gnupg net-tools fail2ban expect
sudo apt install -y mysql-server

sudo wget https://raw.githubusercontent.com/on-air/on-air.github.io/master/shell/firewall.rule -P /tmp/
sudo mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
sudo cp /tmp/firewall.rule /etc/ufw/before.rules

sudo wget https://raw.githubusercontent.com/on-air/on-air.github.io/master/shell/db/my-sql.config -P /tmp/
sudo mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
sudo cp /tmp/my-sql.config /etc/mysql/mysql.conf.d/mysqld.cnf

sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3306/tcp

sudo mysql_secure_installation
mysql
CREATE USER 'master'@'%' IDENTIFIED WITH mysql_native_password BY 'My_SQL.3306';
CREATE DATABASE master;
CREATE DATABASE client;
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';
exit

sudo wget https://raw.githubusercontent.com/on-air/on-air.github.io/master/shell/db/mysql_secure_installation.sh
sudo chmod +x mysql_secure_installation.sh
sudo ./mysql_secure_installation.sh 'My_SQL.3306'
sudo echo -en "CREATE USER 'master'@'%' IDENTIFIED WITH mysql_native_password BY 'My_SQL.3306';
CREATE DATABASE master;
CREATE DATABASE client;
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';" > my.sql
sudo mysql < my.sql
sudo echo -en "[mysqld]
user = mysql
bind-address = 0.0.0.0
mysqlx-bind-address = 127.0.0.1
key_buffer_size = 16M
myisam-recover-options = BACKUP
log_error = /var/log/mysql/error.log
max_binlog_size = 100M" > /etc/mysql/mysql.conf.d/mysqld.cnf

sudo wget https://raw.githubusercontent.com/on-air/on-air.github.io/master/shell/firewall.rule -P /tmp/


sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3306/tcp
