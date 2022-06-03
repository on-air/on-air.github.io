#!/bin/bash

bot_url="https://cd.netizen.ninja"

bot_init () {
	rm -rf /var/bot
	mkdir /var/bot
	}

bot_update () {
	rm /tmp/cli.sh
	rm /tmp/cli.js
	rm /tmp/module.rar
	rm /tmp/package.rar
	rm -rf /var/bot/node_modules/*
	rm -rf /var/bot/node_packages/*
	wget -P /tmp/ $bot_url/bot/cli.sh
	wget -P /tmp/ $bot_url/bot/cli.js
	wget -P /tmp/ $bot_url/bot/module.rar
	wget -P /tmp/ $bot_url/bot/package.rar
	sudo chmod +x /tmp/cli.sh
	sudo cp /tmp/cli.sh /usr/bin/bot
	cp /tmp/cli.js /var/bot/cli.js
	unrar x -P$1 /tmp/module.rar /var/bot/node_modules
	unrar x -P$1 /tmp/package.rar /var/bot/node_packages
	cp /var/1.json /var/bot/cli.json
	}

bot_ng () {
	echo ""
	}

bot_ng_setup () {
	rm /tmp/ng.config
	wget -P /tmp/ $bot_url/server/engine-x/ng.config
	if [ -f "/etc/nginx/nginx.conf.bak" ]
	then
		sudo cp /tmp/ng.config /etc/nginx/nginx.conf
	else
		sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
		sudo cp /tmp/ng.config /etc/nginx/nginx.conf
		fi
	}

bot_firewall () {
	sudo ufw allow http
	sudo ufw allow https
	}

bot_firewall_reload () {
	sudo ufw reload
	}

bot_firewall_rule_setup () {
	wget -P /tmp/ https://cd.netizen.ninja/security/firewall.rule
	if [ -f "/etc/ufw/before.rules.bak" ]
	then
		sudo cp /tmp/firewall.rule /etc/ufw/before.rules
	else
		sudo mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
		sudo cp /tmp/firewall.rule /etc/ufw/before.rules
		fi
	}

bot_db_my_sql () {
	mysql_secure_installation
	}

bot_db_my_sql_setup () {
	sudo mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
	sudo cp /tmp/my-sql.config /etc/mysql/mysql.conf.d/mysqld.cnf
	}

bot_db_my_sql_firewall_setup () {
	sudo ufw allow 3306/tcp
	}

if [ "$1" == "--help" ]
then
	echo "[BOT]"
elif [ "$1" == "update" ]
then
	read -sp 'password: ' var_password
	echo
	bot_update $var_password
elif [ "$1" == "firewall" ] && [ "$2" == "install" ] && [ "$3" == "tcp" ]
then
	if [ "$3" == "tcp" ]
	then
		bot_firewall
		fi
	if [ "$3" == "rule" ]
	then
		bot_firewall_rule_setup
		fi
	bot_firewall_reload
elif [ "$1" == "ng" ] && [ "$2" == "config" ] && [ "$3" == "default" ]
then
	read -p 'port: ' var_port
	echo
	node /var/bot/cli.js ng config $3 $var_port
elif [ "$1" == "ng" ] && [ "$2" == "config" ]
then
	read -p 'name: ' var_name
	read -p 'host: ' var_host
	read -p 'port: ' var_port
	echo
	node /var/bot/cli.js ng config $3 $var_name $var_host $var_port
else
	node /var/bot/cli.js "$@"
	fi
