#!/bin/bash

file_backup="/etc/nginx/nginx.conf.bak"
file_config="/etc/nginx/nginx.conf"
file_configuration="$apt_files/ng.config"
file_default="/etc/nginx/sites-enabled/default"
file_router="/etc/nginx/sites-enabled/0.0.0.0"
dir_log="/var/log/nginx"

do_install () {
	dir_create $dir_log
	dir_delete $html_dir
	file_delete $file_default
	file_delete $file_router
	if [ -f $file_backup ]
	then
		cp $file_configuration $file_config
	else
		mv $file_config $file_backup
		cp $file_configuration $file_config
		fi
	}

do_install_tcp () {
	sudo ufw allow 3000/tcp
	}

if [ "$1" == "install" ] && [ "$2" == "tcp" ]
then
	do_install_tcp
elif [ "$1" == "install" ]
then
	do_install
elif [ "$1" == "start" ]
then
	sudo systemctl start nginx.service
elif [ "$1" == "stop" ]
then
	sudo systemctl stop nginx.service
elif [ "$1" == "restart" ]
then
	sudo systemctl restart nginx.service
elif [ "$1" == "reload" ]
then
	sudo systemctl reload nginx.service
elif [ "$1" == "config" ]
then
	if [ "$2" == "" ]
	then
		read -p "file: " var_file
		read -p "name: " var_name
		read -p "host: " var_host
		read -p "port: " var_port
		echo
	elif [ "$2" == "default" ]
	then
		do_install
		var_file="0.0.0.0"
		var_name="0.0.0.0"
		var_host="0.0.0.0"
		if [ "$3" == "" ]
		then
			read -p "port: " var_port
			echo
		else
			var_port=$3
			fi
	else
		var_file=$2
		var_name=$3
		var_host=$4
		var_port=$5
		fi
	sudo node $cli_script ng config "$var_file" "$var_name" "$var_host" "$var_port"
	sudo systemctl reload nginx.service
else
	echo
	fi
