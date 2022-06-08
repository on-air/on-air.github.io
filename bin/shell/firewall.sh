#!/bin/bash

file_backup="/etc/ufw/before.rules.bak"
file_config="/etc/ufw/before.rules"
file_configuration="$apt_files/firewall.rule"

do_install_rule () {
	if [ -f $file_backup ]
	then
		cp $file_configuration $file_config
	else
		mv $file_config $file_backup
		cp $file_configuration $file_config
		fi
	}

if [ "$1" == "install" ] && [ "$2" == "tcp" ]
then
	sudo ufw allow http
	sudo ufw allow https
if [ "$1" == "install" ] && [ "$2" == "rule" ]
then
	do_install_rule
elif [ "$1" == "install" ]
then
	sudo ufw allow http
	sudo ufw allow https
	do_install_rule
elif [ "$1" == "allow" ]
then
	sudo ufw allow $2
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
	sudo ufw reload
else
	echo
	fi
