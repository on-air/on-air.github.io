#!/bin/bash

if [ "$1" == "--help" ]
	then
		echo "ng install"
		echo "ng install security firewall"
		echo "ng install node"
		echo "ng install express vue"
		echo "ng init"
		echo "ng update"
		echo "ng update repository"
		echo "ng vue init [app]"
		echo "ng vue create [app] [child]"
elif [ "$1" == "install" ] && [ "$2" == "security" ] && [ "$3" == "firewall" ]
	then
		wget -P /tmp/ https://cd.netizen.ninja/shell/security/firewall.rule
		sudo mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
		sudo cp /tmp/firewall.rule /etc/ufw/before.rules
elif [ "$1" == "install" ] && [ "$2" == "node" ]
	then
		curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
		sudo apt install -y nodejs
		sudo npm install -g pm2
elif [ "$1" == "install" ] && [ "$2" == "express" ] && [ "$3" == "vue" ]
	then
		sudo npm install -g @vue/cli
elif [ "$1" == "install" ]
	then
		rm /tmp/ng.sh
		wget -P /tmp/ https://cd.netizen.ninja/shell/ng.sh
		sudo chmod +x /tmp/ng.sh
		sudo cp /tmp/ng.sh /usr/bin/ng
elif [ "$1" == "init" ]
	then
		mkdir /var/app
		mkdir /var/application
		mkdir /var/node
		mkdir /var/log/app
		mkdir /var/log/application
		mkdir /var/log/node
elif [ "$1" == "update" ] && [ "$2" == "repository" ]
	then
		if [ "$3" != "" ]
			then
				rm -rf /var/node/node_modules/*
				rm -rf /var/node/node_packages/*
				rm /tmp/node.rar
				rm /tmp/vue.rar
				wget -P /tmp/ https://cd.netizen.ninja/file/node.rar
				wget -P /tmp/ https://cd.netizen.ninja/file/vue.rar
				unrar x -p$3 /tmp/node.rar /var/node/node_modules
				unrar x -p$3 /tmp/vue.rar /var/node/node_packages
		else
			echo "unrar --password"
		fi
elif [ "$1" == "update" ]
	then
		cp -r /var/node/node_modules/* /var/app/node_modules/
elif [ "$1" == "vue" ] && [ "$2" == "init" ]
	then
		if [ "$3" != "" ]
			then
				rm -rf app/$3
				mkdir app/$3
				cp -r /var/node/node_packages/server app/$3/server
				cp -r /var/node/node_packages/client app/$3/client
				cd app/$3/server
				npm install
				cd ../client/default
				npm install
		else
			rm -rf app/$3/client/$4
			cp -r /var/node/node_packages/client/default app/$3/client/$4
			cd app/$3/client/$4
			npm install
		fi
elif [ "$1" == "vue" ] && [ "$2" == "create" ]
	then
		if [ "$3" != "" ]
			then
				rm -rf app/$3/cgi-public/$4
				cp -r /var/node/node_packages/cgi-public/default app/$3/cgi-public/$4
				cd app/$3/cgi-public/$4
				npm install
		else
			echo "app --name"
		fi
else
	echo ""
	fi
