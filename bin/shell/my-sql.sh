#!/bin/bash

file_backup="/etc/mysql/mysql.conf.d/mysqld.cnf.bak"
file_config="/etc/mysql/mysql.conf.d/mysqld.cnf"
file_configuration="$apt_files/my-sql.config"

express_file="/var/express/package.js"
express_dir="/var/express"

do_install () {
	if [ -f $file_backup ]
	then
		cp $file_configuration $file_config
	else
		mv $file_config $file_backup
		cp $file_configuration $file_config
		fi
	}

do_install_tcp () {
	sudo ufw allow 3306/tcp
	}

if [ "$1" == "install" ] && [ "$2" == "tcp" ]
then
	do_install_tcp
elif [ "$1" == "install" ]
then
	do_install
elif [ "$1" == "start" ]
then
	echo
elif [ "$1" == "stop" ]
then
	echo
elif [ "$1" == "restart" ]
then
	echo
elif [ "$1" == "reload" ]
then
	echo
elif [ "$1" == "run" ]
then
	node $express_dir/package.db "$2" "$3" "$4" "$5"
else
	echo
	fi
