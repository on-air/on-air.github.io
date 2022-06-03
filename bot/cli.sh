#!/bin/bash

bot_url="https://cd.netizen.ninja"

bot_init () {
	rm -rf /var/bot/node_packages
	rm -rf /var/bot/node_modules
	rm -rf /var/bot
	mkdir /var/bot
	mkdir /var/bot/node_modules
	mkdir /var/bot/node_packages
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
	sudo cp /tmp/ng.config /etc/nginx/nginx.conf
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
	sudo mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
	sudo cp /tmp/firewall.rule /etc/ufw/before.rules
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
	bot_update
elif [ "$1" == "firewall" ] && [ "$2" == "install" ] && [ "$3" == "tcp" ]
then
	bot_firewall
	bot_firewall_reload
elif [ "$1" == "firewall" ] && [ "$2" == "install" ] && [ "$3" == "rule" ]
then
	bot_firewall_rule_setup
	bot_firewall_reload
else
	node /var/bot/cli.js "$@"
	fi
