#!/bin/bash

if [ "$1" == "--help" ]
	then
		echo "node package c --help"
elif [ "$1" == "init" ]
	then
		mkdir /var/node
		mkdir /var/node/node_modules
		mkdir /var/node/node_packages
		mkdir /var/log/www
elif [ "$1" == "update" ] && [ "$2" == "script" ]
	then
		rm /tmp/npc.sh
		wget -P /tmp/ https://cd.netizen.ninja/shell/npc.sh
		sudo chmod +x /tmp/npc.sh
		sudo cp /tmp/npc.sh /usr/bin/npc
elif [ "$1" == "update" ] && [ "$2" == "repository" ]
	then
		if [ "$3" == "" ]
			then
				echo "unzip --password"
		else
			rm /tmp/node.zip
			wget -P /tmp/ https://cd.netizen.ninja/shell/node.zip
			unzip -P $3 /tmp/node.zip -d /var/node/node_modules
		fi
elif [ "$1" == "update" ]
	then
		cp -r /var/node/node_modules/* node_modules/
else
	echo ""
	fi
