#!/bin/bash

bot_url="https://cd.netizen.ninja"

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
	wget -P /tmp/ $bot_url/server/engine-x/ng.config
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

if [ "$1" == "--help" ]
then
	echo "[BOT]"
elif [ "$1" == "update" ]
then
	if [ "$2" == "" ]
	then
		read -sp "password: " var_password
		echo
	else
		var_password=$2
		fi
	bot_update "$var_password"
elif [ "$1" == "firewall" ] && [ "$2" == "install" ]
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
elif [ "$1" == "ng" ] && [ "$2" == "start" ]
then
	bot_ng_start
elif [ "$1" == "ng" ] && [ "$2" == "restart" ]
then
	bot_ng_restart
elif [ "$1" == "ng" ] && [ "$2" == "reload" ]
then
	bot_ng_reload
elif [ "$1" == "ng" ] && [ "$2" == "config" ]
then
	if [ "$3" == "" ]
	then
		read -p "file: " var_file
		read -p "name: " var_name
		read -p "host: " var_host
		read -p "port: " var_port
		echo
	elif [ "$3" == "default" ]
	then
		bot_ng_setup
		var_file="0.0.0.0"
		var_name="0.0.0.0"
		var_host="0.0.0.0"
		if [ "$4" == "" ]
		then
			read -p "port: " var_port
			echo
		else
			var_port=$4
			fi
	else
		var_file=$3
		var_name=$4
		var_host=$5
		var_port=$6
		fi
	node /var/bot/cli.js ng config "$var_file" "$var_name" "$var_host" "$var_port"
	bot_ng_reload
else
	node /var/bot/cli.js "$@"
	fi
