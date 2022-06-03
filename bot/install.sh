#!/bin/bash

bot_url="https://cd.netizen.ninja"

if [ "$1" == "" ]
then
	read -sp "password: " var_password
	echo
else
	var_password=$1
	fi

bot_update () {
	if [ ! -d "/var/bot" ]
	then
		mkdir /var/bot
		fi
	rm /tmp/cli.sh
	rm /tmp/cli.js
	rm /tmp/bot.rar
	wget -P /tmp/ $bot_url/bot/cli.sh
	wget -P /tmp/ $bot_url/bot/cli.js
	wget -P /tmp/ $bot_url/bot/bot.rar
	sudo chmod +x /tmp/cli.sh
	sudo cp /tmp/cli.sh /usr/bin/bot
	cp /tmp/cli.js /var/bot/cli.js
	cp /var/1.json /var/bot/cli.json
	unrar x -P$1 /tmp/bot.rar /var/bot -o+
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
	rm /tmp/ng.config
	wget -P /tmp/ $bot_url/bot/ng.config
	if [ -f "/etc/nginx/nginx.conf.bak" ]
	then
		cp /tmp/ng.config /etc/nginx/nginx.conf
	else
		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
		cp /tmp/ng.config /etc/nginx/nginx.conf
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
	rm /tmp/firewall.rule
	wget -P /tmp/ https://cd.netizen.ninja/security/firewall.rule
	if [ -f "/etc/ufw/before.rules.bak" ]
	then
		cp /tmp/firewall.rule /etc/ufw/before.rules
	else
		mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
		cp /tmp/firewall.rule /etc/ufw/before.rules
		fi
	}

bot_db_my_sql () {
	mysql_secure_installation
	}

bot_db_my_sql_setup () {
	mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
	cp /tmp/my-sql.config /etc/mysql/mysql.conf.d/mysqld.cnf
	}

bot_db_my_sql_firewall_setup () {
	sudo ufw allow 3306/tcp
	}

bot_update "$var_password"
bot_ng_setup
bot_ng_reload
bot_firewall
bot_firewall_rule_setup
bot_firewall_reload
