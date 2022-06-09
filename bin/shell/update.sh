#!/bin/bash

do_init () {
	dir_create $apt_dir
	dir_create $apt_files
	dir_create $node_modules
	dir_create $node_packages
	}

do_clear () {
	dir_delete $apt_files/
	dir_delete $node_modules/
	dir_delete $node_packages/
	}

do_download () {
	file_download cli.sh from $cli_url/ to $apt_dir/
	file_download cli.js from $cli_url/ to $apt_dir/
	file_download cli.min.js from $cli_url/ to $apt_dir/
	file_download ecosystem.config.js from $cli_url/ to $apt_dir/
	file_download ecosystem.config.json from $cli_url/ to $apt_dir/
	file_download node_module.rar from $apt_files_url/ to $apt_files/
	file_download node_package.rar from $apt_files_url/ to $apt_files/
	file_download apache.config from $apt_files_url/ to $apt_files/
	file_download apache.template from $apt_files_url/ to $apt_files/
	file_download ng.config from $apt_files_url/ to $apt_files/
	file_download ng.template from $apt_files_url/ to $apt_files/
	file_download my-sql.config from $apt_files_url/ to $apt_files/
	file_download firewall.rule from $apt_files_url/ to $apt_files/
	}

bashell () {
	file_delete /tmp/$1
	if [ "$3" == "" ]
	then
		file_download $1 from $apt_url/bin/shell/
	else
		file_download $1 from $apt_url/bin/shell/$3/
		fi
	sudo chmod +x /tmp/$1
	if [ "$2" == "" ]
	then
		sudo mv /tmp/$1 /usr/bin/$1
	else
		sudo mv /tmp/$1 /usr/bin/$2
		fi
	}

if [ "$1" == "bash" ]
then
	dir_create /tmp/extra
	bashell file_download.sh file_download extra
	bashell file_extract.sh file_extract extra
	bashell file_delete.sh file_delete extra
	bashell file_copy.sh file_copy extra
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
elif [ "$1" == "" ]
then
	read -sp "password: " password
	echo
else
	password=$1
	fi

do_init
do_clear
do_download
sudo chmod +x $cli_shell
sudo file_copy $cli_shell $cli_exe
file_copy $j_son $cli_son
file_extract $node_modules_archive $node_modules $password
file_extract $node_packages_archive $node_packages $password
