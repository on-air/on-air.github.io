#!/bin/bash

CD_URL="https://cd.netizen.ninja"
CD_URL_DB="$CD_URL/db"
CD_URL_SECURITY="$CD_URL/security"
BOT_URL="$CD_URL/bot"
BOT_URL_FILE="$BOT_URL/node_files"
BOT_EXE="/usr/bin/bot"
BOT_DIR="/var/bot"
NODE_FILES="$BOT_DIR/node_files"
NODE_MODULES="$BOT_DIR/node_modules"
NODE_PACKAGES="$BOT_DIR/node_packages"
NODE_PACKAGES_EXPRESS="$NODE_PACKAGES/express"
NODE_PACKAGES_ANGULAR="$NODE_PACKAGES/angular"
NODE_PACKAGES_VUE="$NODE_PACKAGES/vue"
CLI_SHELL="$BOT_DIR/cli.sh"
CLI_SCRIPT="$BOT_DIR/cli.js"

w_get () {
	rm /tmp/$1
	wget -q -P /tmp/ $3$1
	if [ -d "$5" ]
	then
		mv /tmp/$1 $5$1
	else
		mv /tmp/$1 $5
		fi
	}

bot_upgrade () {
	if [ -d "node_modules" ]
	then
		cp -r $NODE_MODULES/* node_modules/
		fi
	}

bot_update () {
	if [ ! -d "$BOT_DIR" ]
	then
		bot_update_init
		fi
	bot_update_clear
	bot_update_download
	sudo chmod +x $CLI_SHELL
	sudo cp $CLI_SHELL $BOT_EXE
	cp /var/1.json $BOT_DIR/cli.json
	unrar x -P$1 $NODE_FILES/node_module.rar $NODE_MODULES -o+
	unrar x -P$1 $NODE_FILES/node_package.rar $NODE_PACKAGES -o+
	}

bot_update_init () {
	mkdir $BOT_DIR
	mkdir $NODE_FILES
	mkdir $NODE_MODULES
	mkdir $NODE_PACKAGES
	}

bot_update_clear () {
	rm -rf $NODE_FILES/*
	rm -rf $NODE_MODULES/*
	rm -rf $NODE_PACKAGES/*
	}

bot_update_download () {
	w_get cli.sh from $BOT_URL/ to $BOT_DIR/
	w_get cli.js from $BOT_URL/ to $BOT_DIR/
	w_get cli.min.js from $BOT_URL/ to $BOT_DIR/
	w_get ecosystem.config.js from $BOT_URL/ to $BOT_DIR/
	w_get ecosystem.config.json from $BOT_URL/ to $BOT_DIR/
	w_get node_module.rar from $BOT_URL_FILE/ to $NODE_FILES/
	w_get node_package.rar from $BOT_URL_FILE/ to $NODE_FILES/
	w_get apache.config from $BOT_URL_FILE/ to $NODE_FILES/
	w_get apache.template from $BOT_URL_FILE/ to $NODE_FILES/
	w_get ng.config from $BOT_URL_FILE/ to $NODE_FILES/
	w_get ng.template from $BOT_URL_FILE/ to $NODE_FILES/
	w_get my-sql.config from $CD_URL_DB/ to $NODE_FILES/
	w_get firewall.rule from $CD_URL_SECURITY/ to $NODE_FILES/
	}

NG_FILE="$NODE_FILES/ng.config"
NG_FILE_CONFIG="/etc/nginx/nginx.conf"
NG_FILE_BACKUP="/etc/nginx/nginx.conf.bak"
NG_FILE_DEFAULT="/etc/nginx/sites-enabled/default"
NG_FILE_DEFAULT_ROUTER="/etc/nginx/sites-enabled/0.0.0.0"

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

bot_ng_stop () {
	sudo systemctl stop nginx.service
	}

bot_ng_setup () {
	rm $NG_FILE_DEFAULT
	rm $NG_FILE_DEFAULT_ROUTER
	if [ -f "$NG_FILE_BACKUP" ]
	then
		cp $NG_FILE $NG_FILE_CONFIG
	else
		mv $NG_FILE_CONFIG $NG_FILE_BACKUP
		cp $NG_FILE $NG_FILE_CONFIG
		fi
	}

DB_MY_SQL_FILE="$NODE_FILES/my-sql.config"
DB_MY_SQL_FILE_CONFIG="/etc/mysql/mysql.conf.d/mysqld.cnf"
DB_MY_SQL_FILE_BACKUP="/etc/mysql/mysql.conf.d/mysqld.cnf.bak"

bot_db_my_sql () {
	echo
	}

bot_db_my_sql_setup () {
	if [ ! -d "$DB_MY_SQL_FILE_BACKUP" ]
	then
		cp $DB_MY_SQL_FILE $DB_MY_SQL_FILE_CONFIG
	else
		mv $DB_MY_SQL_FILE_CONFIG $DB_MY_SQL_FILE_BACKUP
		cp $DB_MY_SQL_FILE $DB_MY_SQL_FILE_CONFIG
		fi
	}

bot_db_my_sql_firewall_setup () {
	sudo ufw allow 3306/tcp
	}

EXPRESS_FILE="/var/express/package.js"
EXPRESS_DIR="/var/express"
PM_ECOSYSTEM="$BOT_DIR/ecosystem.config.js"

bot_express () {
	echo
	}

bot_express_init () {
	if [ ! -d "$EXPRESS_DIR" ]
	then
		mkdir $EXPRESS_DIR
		fi
	cp -r $NODE_PACKAGES_EXPRESS/* $EXPRESS_DIR/
	cd $EXPRESS_DIR
	npm install
	bot_upgrade
	sudo pm2 start $PM_ECOSYSTEM
	}

VUE_FILE="/var/vue/package.js"
VUE_DIR="/var/vue"

bot_vue () {
	echo
	}

FIREWALL_FILE="$NODE_FILES/firewall.rule"
FIREWALL_FILE_CONFIG="/etc/ufw/before.rules"
FIREWALL_FILE_BACKUP="/etc/ufw/before.rules.bak"

bot_firewall () {
	sudo ufw allow http
	sudo ufw allow https
	}

bot_firewall_reload () {
	sudo ufw reload
	}

bot_firewall_rule_setup () {
	if [ -f "$FIREWALL_FILE_BACKUP" ]
	then
		cp $FIREWALL_FILE $FIREWALL_FILE_CONFIG
	else
		mv $FIREWALL_FILE_CONFIG $FIREWALL_FILE_BACKUP
		cp $FIREWALL_FILE $FIREWALL_FILE_CONFIG
		fi
	}

if [ "$1" == "--help" ]
then
	echo "[BOT]"
elif [ "$1" == "upgrade" ]
then
	bot_upgrade
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
elif [ "$1" == "ng" ] && [ "$2" == "stop" ]
then
	bot_ng_stop
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
	node $CLI_SCRIPT ng config "$var_file" "$var_name" "$var_host" "$var_port"
	bot_ng_reload
else
	node $CLI_SCRIPT "$@"
	fi
