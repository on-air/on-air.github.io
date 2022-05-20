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
				rm /tmp/node.zip
				rm /tmp/vue.zip
				wget -P /tmp/ https://cd.netizen.ninja/shell/node.zip
				wget -P /tmp/ https://cd.netizen.ninja/shell/vue.zip
				unzip -P $3 /tmp/node.zip -d /var/node/node_modules
				unzip -P $3 /tmp/vue.zip -d /var/node/node_packages
		else
			echo "unzip --password"
		fi
elif [ "$1" == "update" ]
	then
		cp -r /var/node/node_modules/* node_modules/
elif [ "$1" == "vue" ] && [ "$2" == "init" ]
	then
		if [ "$3" != "" ]
			then
				mkdir app/$3
				cp -r /var/node/node_packages/cgi-bin app/$3/cgi-bin
				cp -r /var/node/node_packages/cgi-public app/$3/cgi-public
				mv app/$3/cgi-public/default app/$3/cgi-public/www
				cd app/$3/cgi-public/www
		else
			echo "app --name"
		fi
else
	echo ""
	fi
