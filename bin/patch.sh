#!/bin/bash

bashell () {
	if [ -f "/tmp/$1" ]
	then
		rm /tmp/$1
		fi
	if [ "$3" == "" ]
	then
		wget -q -P /tmp/ $cli_shell_url/$1
	else
		wget -q -P /tmp/ $cli_shell_url/$3/$1
		fi
	sudo chmod +x /tmp/$1
	if [ "$2" == "" ]
	then
		sudo mv /tmp/$1 /usr/bin/$1
	else
		sudo mv /tmp/$1 /usr/bin/$2
		fi
	}

bashell file_download.sh file_download extra
bashell file_extract.sh file_extract extra
bashell file_create.sh file_create extra
bashell file_delete.sh file_delete extra
bashell file_copy.sh file_copy extra
bashell file_move.sh file_move extra
bashell dir_create.sh dir_create extra
bashell dir_delete.sh dir_delete extra
bashell dir_copy.sh dir_copy extra

bashell test.sh
bashell firewall.sh
bashell update.sh
bashell upgrade.sh
bashell ng.sh
bashell my-sql.sh
bashell express.sh
