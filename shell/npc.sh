#!/bin/bash

if [ "$1" == "--help" ]
	then
		echo "virtual package --help"
elif [ "$1" == "init" ]
	then
		mkdir app
		mkdir application
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
		if [ "$3" != "" ]
			then
				rm -rf /var/node/node_modules/*
				rm -rf /var/node/node_packages/*
				rm /tmp/node.rar
				rm /tmp/vue.rar
				wget -P /tmp/ https://cd.netizen.ninja/shell/node.rar
				wget -P /tmp/ https://cd.netizen.ninja/shell/vue.rar
				unrar x -p$3 /tmp/node.rar /var/node/node_modules
				unrar x -p$3 /tmp/vue.rar /var/node/node_packages
		else
			echo "unrar --password"
		fi
elif [ "$1" == "update" ]
	then
		cp -r /var/node/node_modules/* node_modules/
elif [ "$1" == "vue" ] && [ "$2" == "init" ]
	then
		if [ "$3" != "" ]
			then
				rm -rf app/$3
				mkdir app/$3
				cp -r /var/node/node_packages/cgi-bin app/$3/cgi-bin
				cp -r /var/node/node_packages/cgi-public app/$3/cgi-public
				cd app/$3/cgi-public/default
		else
			echo "app --name"
		fi
else
	echo ""
	fi
