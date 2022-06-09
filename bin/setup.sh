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
export cli_shell_url="$apt_url/bin/shell"
export cli_script="$apt_dir/cli.js"
export cli_son="$apt_dir/cli.json"
export www_data="/var/www"
export html_dir="/var/www/html"

#
# description
#

wget -P /tmp/ $apt_url/bin/bash/rc
mv /tmp/rc .bash_aliases
. ~/.bash_aliases

#
# description
#

wget -P /tmp/ $apt_url/bin/install.sh
sudo chmod +x /tmp/install.sh
sudo mv /tmp/install.sh /usr/bin/install.sh

wget -P /tmp/ $apt_url/bin/patch.sh
sudo chmod +x /tmp/patch.sh
sudo mv /tmp/patch.sh /usr/bin/patch.sh
patch.sh

#
# description
#

install.sh --password
