
CREATE USER 'sys_temp'@'%' IDENTIFIED BY 'password';

SELECT user, host, plugin, authentication_string FROM mysql.user;

GRANT ALL PRIVILEGES ON *.* TO 'sys_temp'@'%';

SHOW GRANTS FOR 'sys_temp'@'%';

FLUSH PRIVILEGES;