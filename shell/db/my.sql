CREATE USER 'master'@'%' IDENTIFIED WITH mysql_native_password BY 'My_SQL.3306';
CREATE DATABASE master;
CREATE DATABASE client;
GRANT ALL PRIVILEGES ON *.* TO 'master'@'%';
