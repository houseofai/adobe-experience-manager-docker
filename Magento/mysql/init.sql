create database magento;
create user 'magento'@'localhost' IDENTIFIED BY 'magento';
GRANT ALL ON magento.* TO 'magento'@'localhost';
flush privileges;
