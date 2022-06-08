#!/bin/bash

express_file="/var/express/package.js"
express_dir="/var/express"

do_install () {
	dir_create $express_dir
	dir_copy $node_packages/express/* $express_dir/
	cd $express_dir
	npm install
	}

if [ "$1" == "install" ]
then
	do_install
elif [ "$1" == "start" ]
then
	upgrade.sh
	sudo pm2 start $proc_ecosystem
else
	echo
	fi
