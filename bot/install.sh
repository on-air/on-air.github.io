#!/bin/bash

bot_url="https://cd.netizen.ninja"

bot_update () {
	if [ ! -d "/var/bot" ]
	then
		mkdir /var/bot
		fi
	rm /tmp/cli.sh
	rm /tmp/cli.js
	rm /tmp/cli.min.js
	rm /tmp/archive.rar
	rm /tmp/ng.config
	rm /tmp/my-sql.config
	rm /tmp/firewall.rule
	wget -P /tmp/ $bot_url/bot/cli.sh
	wget -P /tmp/ $bot_url/bot/cli.js
	wget -P /tmp/ $bot_url/bot/cli.min.js
	wget -P /tmp/ $bot_url/bot/archive.rar
	wget -P /tmp/ $bot_url/bot/ng.config
	wget -P /tmp/ $bot_url/db/my-sql.config
	wget -P /tmp/ $bot_url/security/firewall.rule
	sudo chmod +x /tmp/cli.sh
	sudo cp /tmp/cli.sh /usr/bin/bot
	cp /tmp/cli.js /var/bot/cli.js
	cp /tmp/cli.min.js /var/bot/cli.min.js
	cp /var/1.json /var/bot/cli.json
	unrar x -P$1 /tmp/archive.rar /var/bot -o+
	cp /tmp/ng.config /var/bot/ng.config
	cp /tmp/my-sql.config /var/bot/my-sql.config
	cp /tmp/firewall.rule /var/bot/firewall.rule
	}

bot_ng () {
	echo
	}

bot_ng_start () {
	sudo systemctl start nginx.service
	}

bot_ng_restart () {
	sudo systemctl restart nginx.service
	}

bot_ng_reload () {
	sudo systemctl reload nginx.service
	}

bot_ng_setup () {
	rm /etc/nginx/sites-enabled/default
	rm /etc/nginx/sites-enabled/0.0.0.0
	if [ -f "/etc/nginx/nginx.conf.bak" ]
	then
		cp /var/bot/ng.config /etc/nginx/nginx.conf
	else
		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
		cp /var/bot/ng.config /etc/nginx/nginx.conf
		fi
	}

bot_db_my_sql () {
	echo
	}

bot_db_my_sql_setup () {
	if [ ! -d "/etc/mysql/mysql.conf.d/mysqld.cnf.bak" ]
	then
		cp /var/bot/my-sql.config /etc/mysql/mysql.conf.d/mysqld.cnf
	else
		mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
		cp /var/bot/my-sql.config /etc/mysql/mysql.conf.d/mysqld.cnf
		fi
	}

bot_db_my_sql_firewall_setup () {
	sudo ufw allow 3306/tcp
	}

bot_express () {
	echo
	}

bot_vue () {
	echo
	}

bot_firewall () {
	sudo ufw allow http
	sudo ufw allow https
	}

bot_firewall_reload () {
	sudo ufw reload
	}

bot_firewall_rule_setup () {
	if [ -f "/etc/ufw/before.rules.bak" ]
	then
		cp /var/bot/firewall.rule /etc/ufw/before.rules
	else
		mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
		cp /var/bot/firewall.rule /etc/ufw/before.rules
		fi
	}

if [ "$1" == "" ]
then
	read -sp "password: " var_password
	echo
else
	var_password=$1
	fi

bot_update "$var_password"
bot_ng_setup
bot_ng_reload
bot_firewall
bot_firewall_rule_setup
bot_firewall_reload