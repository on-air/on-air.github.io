#!/bin/bash

file_backup="/etc/mysql/mysql.conf.d/mysqld.cnf.bak"
file_config="/etc/mysql/mysql.conf.d/mysqld.cnf"
file_configuration="$apt_files/my-sql.config"

do_install () {
	if [ -f $file_backup ]
	then
		cp $file_configuration $file_config
	else
		mv $file_config $file_backup
		cp $file_configuration $file_config
		fi
	}

do_install_firewall () {
	sudo ufw allow 3306/tcp
	}

if [ "$1" == "install" ] && [ "$2" == "firewall" ]
then
	do_install_firewall
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
else
	echo
	fi
