#!/bin/bash

if [ "$1" == "--help" ]
then
	echo "npc install"
	echo "npc install firewall security"
	echo "npc install my-sql security"
	echo "npc update script"
	echo "npc update repository --password [password]"
elif [ "$1" == "install" ] && [ "$2" == "firewall" ] && [ "$3" == "security" ]
then
	wget -P /tmp/ https://cd.netizen.ninja/shell/security/firewall.rule
	sudo mv /etc/ufw/before.rules /etc/ufw/before.rules.bak
	sudo cp /tmp/firewall.rule /etc/ufw/before.rules
elif [ "$1" == "install" ] && [ "$2" == "my-sql" ] && [ "$3" == "security" ]
then
	wget -P /tmp/ https://cd.netizen.ninja/shell/db/my-sql.config
	sudo mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.bak
	sudo cp /tmp/my-sql.config /etc/mysql/mysql.conf.d/mysqld.cnf
elif [ "$1" == "install" ]
then
	curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
	sudo apt install -y nodejs
	sudo npm install -g pm2
	mkdir /var/express
	mkdir /var/vue
	mkdir /var/node
	mkdir /var/node/node_modules
	mkdir /var/node/node_packages
	mkdir /var/log/express
	mkdir /var/log/vue
	mkdir /var/log/node
elif [ "$1" == "update" ] && [ "$2" == "script" ]
then
	rm /tmp/npc.sh
	wget -P /tmp/ https://cd.netizen.ninja/shell/npc.sh
	sudo chmod +x /tmp/npc.sh
	sudo cp /tmp/npc.sh /usr/bin/npc
elif [ "$1" == "update" ] && [ "$2" == "repository" ] && [ "$3" == "--password" ]
then
	if [ "$4" != "" ]
	then
		rm -rf /var/node/node_modules/*
		rm -rf /var/node/node_packages/*
		rm /tmp/node_module.rar
		rm /tmp/node_package.rar
		wget -P /tmp/ https://cd.netizen.ninja/node_module.rar
		wget -P /tmp/ https://cd.netizen.ninja/node_package.rar
		unrar x -P$4 /tmp/node_module.rar /var/node/node_modules
		unrar x -P$4 /tmp/node_package.rar /var/node/node_packages
	else
		echo "error : repository is password protect"
	fi
else
	echo ""
	fi
