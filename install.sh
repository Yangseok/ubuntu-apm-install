#!/bin/bash

sudo apt update

sudo apt install -y apache2
sudo systemctl enable apache2.service
sudo systemctl restart apache2.service

### mariadb setup
##sudo apt install -y mariadb-server
##echo " -- set db password -- enter/n/y/n/n/y"
##sudo mysql_secure_installation

# enter
#sudo mysql -uroot -p
#add db, add account, grant flush ...
#sudo vi /etc/mysql/mariadb.conf.d/50-server.cnf
#bind-address           = 127.0.0.1 change
#bind-address           = 0.0.0.0
##sudo systemctl status mariadb.service
##sudo systemctl enable mariadb.service
##sudo systemctl restart mariadb.service

sudo apt install -y php php-bz2 php-common php-cli php-curl php-date php-xml php-gd php-gettext php-json php-mbstring php-mysql php-readline php-soap php-sqlite3 php-tokenizer php-xml php-xmlrpc unzip net-tools

sudo apt install -y php-dev libmcrypt-dev gcc make autoconf libc-dev pkg-config
sudo pecl install mcrypt-1.0.1
# enter
sudo echo "extension=mcrypt.so" | sudo tee -a /etc/php/7.2/apache2/conf.d/mcrypt.ini

sudo apt install -y php-mysql
sudo systemctl restart apache2.service

#Let’s Encrypt
#https://hiseon.me/server/letsencrypt-ssl-certificate/ 
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y python-certbot-apache 
sudo certbot --apache certonly
#add domain
sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests

#sudo vim /etc/apache2/sites-enabled/000-default
#<Directory /var/www>
#Options Indexes FollowSymLinks MultiViews
#AllowOverride All
#Order allow,deny
#</Directory>

sudo systemctl restart apache2
