
REVOKE ALL PRIVILEGES ON *.* FROM 'sys_temp'@'%';

GRANT SELECT ON sakila.* TO 'sys_temp'@'%';

SHOW GRANTS FOR 'sys_temp'@'%';