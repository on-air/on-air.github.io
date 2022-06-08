#!/bin/bash

do_init () {
	dir_create $apt_dir
	dir_create $apt_files
	dir_create $node_modules
	dir_create $node_packages
	}

do_clear () {
	dir_delete $apt_files *
	dir_delete $node_modules *
	dir_delete $node_packages *
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

sudo chmod +x $cli_shell
sudo file_copy $cli_shell $cli_exe
file_copy $j_son $cli_son
file_extract $node_modules_archive $node_modules $1
file_extract $node_packages_archive $node_packages $1
