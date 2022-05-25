CREATE USER 'master'@'%' IDENTIFIED WITH mysql_native_password BY '';
CREATE DATABASE master;
CREATE DATABASE data;
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';
