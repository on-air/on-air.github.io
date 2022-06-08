create user 'master'@'%' identified with mysql_native_password BY '';
create database master;
create database data;
grant all privileges on *.* to 'master'@'%';

alter user 'root'@'localhost' identified with mysql_native_password by '';
flush privileges;
