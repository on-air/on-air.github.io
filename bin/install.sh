#!/bin/bash

if [ "$1" == "" ]
then
	read -p "action: " action
	read -sp "password: " password
	echo
else
	if [ "$1" == "--db" ]
	then
		action=$1
		password=$2
	else
		password=$1
		fi
	fi

if [ "$action" == "--db" ]
then
	update.sh $password
	my-sql.sh install
else
	update.sh $password
	ng.sh install
	ng.sh reload
	express.sh install
	express.sh start
	firewall.sh install
	firewall.sh reload
	fi
