#!/bin/bash

if [ "$1" == "" ]
then
	read -sp "password: " var_password
	echo
else
	var_password=$1
	fi

update.sh $var_password
ng.sh install
ng.sh reload
express.sh install
express.sh start
firewall.sh install
firewall.sh reload
