#!/bin/bash

export j_son="/var/1.json"
sudo apt update
sudo apt upgrade -y
sudo apt install -y aptitude expect curl git zip unzip rar unrar gnupg net-tools fail2ban nginx nginx-extras
curl http://169.254.169.254/v1.json | json_pp > $j_son
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g pm2

#
# description
#

export apt_name="shell"
export apt_url="https://cd.netizen.ninja"
export apt_dir="/var/$apt_name"
export apt_files="$apt_dir/static"
export apt_files_url="$apt_url/static"
export node_modules="$apt_dir/node_modules"
export node_modules_archive="$apt_files/node_module.rar"
export node_packages="$apt_dir/node_packages"
export node_packages_archive="$apt_files/node_package.rar"
export proc_ecosystem="$apt_dir/ecosystem.config.js"
export proc_ecosystem_son="$apt_dir/ecosystem.config.json"
export cli_url="$apt_url/cli"
export cli_exe="/usr/bin/$apt_name"
export cli_shell="$apt_dir/cli.sh"
export cli_script="$apt_dir/cli.js"
export cli_son="$apt_dir/cli.json"
export www_data="/var/www"
export html_dir="/var/www/html"
wget -P /tmp/ $apt_url/bash_rc
mv /tmp/bash_rc .bash_aliases
. ~/.bash_aliases
bashell () {
	rm /tmp/$1
	if [ "$3" == "" ]
	then
		wget -P /tmp/ $apt_url/bin/shell/$1
	else
		wget -P /tmp/ $apt_url/bin/shell/$3/$1
		fi
	sudo chmod +x /tmp/$1
	if [ "$2" == "" ]
	then
		sudo mv /tmp/$1 /usr/bin/$1
	else
		sudo mv /tmp/$1 /usr/bin/$2
		fi
	}

#
# description
#

wget -P /tmp/ $apt_url/bin/install.sh
sudo chmod +x /tmp/install.sh
sudo mv /tmp/install.sh /usr/bin/install.sh

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

#
# description
#

install.sh --password
