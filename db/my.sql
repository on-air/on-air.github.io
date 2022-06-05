CREATE USER 'master'@'%' IDENTIFIED WITH mysql_native_password BY '';
CREATE DATABASE master;
CREATE DATABASE data;
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';

sudo mysql
alter user 'root'@'localhost' identified with mysql_native_password by 'xxx';
flush privileges;
sudo mysql_secure_installation
