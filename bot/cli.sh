#!/bin/bash

bot_url="https://cd.netizen.ninja"

bot_update () {
	if [ ! -d "/var/bot" ]
	then
		bot_update_init
		fi
	bot_update_clear
	bot_update_download
	sudo chmod +x /tmp/cli.sh
	sudo cp /tmp/cli.sh /usr/bin/bot
	cp /tmp/cli.sh /var/bot/cli.sh
	cp /tmp/cli.js /var/bot/cli.js
	cp /tmp/cli.min.js /var/bot/cli.min.js
	cp /var/1.json /var/bot/cli.json
	unrar x -P$1 /tmp/node.rar /var/bot/node_modules -o+
	unrar x -P$1 /tmp/express.rar /var/bot/node_packages/express -o+
	cp /tmp/apache.config /var/bot/node_process/apache.config
	cp /tmp/ng.config /var/bot/node_process/ng.config
	cp /tmp/ng.template /var/bot/node_process/ng.template
	cp /tmp/my-sql.config /var/bot/node_process/my-sql.config
	cp /tmp/firewall.rule /var/bot/node_process/firewall.rule
	}

bot_update_init () {
	mkdir /var/bot
	mkdir /var/bot/node_modules
	mkdir /var/bot/node_packages
	mkdir /var/bot/node_packages/express
	mkdir /var/bot/node_process
	}

bot_update_clear () {
	rm -rf /var/bot/node_modules/*
	rm -rf /var/bot/node_packages/express/*
	rm -rf /var/bot/node_process/*
	rm /tmp/cli.sh
	rm /tmp/cli.js
	rm /tmp/cli.min.js
	rm /tmp/node.rar
	rm /tmp/express.rar
	rm /tmp/apache.config
	rm /tmp/ng.config
	rm /tmp/ng.template
	rm /tmp/my-sql.config
	rm /tmp/firewall.rule
	}

bot_update_download () {
	wget -P /tmp/ $bot_url/bot/cli.sh
	wget -P /tmp/ $bot_url/bot/cli.js
	wget -P /tmp/ $bot_url/bot/cli.min.js
	wget -P /tmp/ $bot_url/bot/node_process/node.rar
	wget -P /tmp/ $bot_url/bot/node_process/express.rar
	wget -P /tmp/ $bot_url/bot/node_process/apache.config
	wget -P /tmp/ $bot_url/bot/node_process/ng.config
	wget -P /tmp/ $bot_url/bot/node_process/ng.template
	wget -P /tmp/ $bot_url/db/my-sql.config
	wget -P /tmp/ $bot_url/security/firewall.rule
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
		cp /var/bot/node_process/ng.config /etc/nginx/nginx.conf
	else
		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
		cp /var/bot/node_process/ng.config /etc/nginx/nginx.conf
		fi
	}

bot_db_my_sql () {
	echo
	}

bot_db_my_sql_setup () {
	if [ ! -d "/etc/mysql/mysql.conf.d/mysqld.cnf.bak" ]
	then
		cp /var/bot/node_process/my-sql.config /etc/mysql/mysql.conf.d/mysqld.cnf
	else
		mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
		cp /var/bot/node_process/my-sql.config /etc/mysql/mysql.conf.d/mysqld.cnf
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
		cp /var/bot/node_process/firewall.rule /etc/ufw/before.rules
	else
		mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
		cp /var/bot/node_process/firewall.rule /etc/ufw/before.rules
		fi
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
