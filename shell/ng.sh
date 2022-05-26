#!/bin/bash

if [ "$1" == "--help" ]
then
	echo "ng install security firewall"
	echo "ng install node"
	echo "ng install express vue"
	echo "ng update script"
	echo "ng update repository --password [password]"
	echo "ng app init"
	echo "ng app update"
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
	sudo npm install -g @vue/cli
elif [ "$1" == "update" ] && [ "$2" == "script" ]
then
	rm /tmp/ng.sh
	wget -P /tmp/ https://cd.netizen.ninja/shell/ng.sh
	sudo chmod +x /tmp/ng.sh
	sudo cp /tmp/ng.sh /usr/bin/ng
elif [ "$1" == "update" ] && [ "$2" == "repository" ] && [ "$3" == "--password" ]
then
	if [ "$5" != "" ]
	then
		rm -rf /var/node/node_modules/*
		rm -rf /var/node/node_packages/express/*
		rm -rf /var/node/node_packages/vue/*
		rm /tmp/node.rar
		rm /tmp/express.rar
		rm /tmp/vue.rar
		wget -P /tmp/ https://cd.netizen.ninja/file/node.rar
		wget -P /tmp/ https://cd.netizen.ninja/file/express.rar
		wget -P /tmp/ https://cd.netizen.ninja/file/vue.rar
		unrar x -p$3 /tmp/node.rar /var/node/node_modules
		unrar x -p$3 /tmp/express.rar /var/node/node_packages/express
		unrar x -p$3 /tmp/vue.rar /var/node/node_packages/vue
	else
		echo "error : repository is password protect"
	fi
elif [ "$1" == "update" ] && [ "$2" == "repository" ]
	then
		cp -r /var/node/node_modules/* /var/express/node_modules/
		if [ -d "node_modules" ]
			then
				cp -r /var/node/node_modules/* node_modules/
		fi
elif [ "$1" == "init" ]
	then
		mkdir /var/express
		mkdir /var/vue
		mkdir /var/node
		mkdir /var/node/node_modules
		mkdir /var/node/node_packages
		mkdir /var/node/node_packages/express
		mkdir /var/node/node_packages/vue
		mkdir /var/log/express
		mkdir /var/log/vue
		mkdir /var/log/node
elif [ "$1" == "vue" ] && [ "$2" == "init" ]
	then
		if [ "$3" != "" ]
			then
				cp -r /var/node/node_packages/express /var/express
				cp -r /var/node/node_packages/vue /var/vue
				cd /var/express
				npm install
				cd /var/vue/default
				npm install
		else
			if [ ! -d "/var/vue/$0/$0" ]
				then
					echo ""
			fi
			rm -rf /var/vue/$4/$4
			cp -r /var/node/node_packages/vue/default /var/vue/$4/$4
			cd /var/vue/$4/$4
			npm install
		fi
else
	echo ""
	fi
