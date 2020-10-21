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

sudo apt install -y php php-bz2 php-common php-cli php-curl php-date php-xml php-gd php-zip php-json php-mbstring php-mysql php-readline php-soap php-dev php-pear php-sqlite3 php-tokenizer php-xml php-xmlrpc unzip net-tools

sudo apt install -y libmcrypt-dev gcc make autoconf libc-dev pkg-config
sudo pecl install mcrypt-1.0.1
# enter
sudo echo "extension=mcrypt.so" | sudo tee -a /etc/php/7.2/apache2/conf.d/mcrypt.ini

sudo apt install -y php-mysql

#add domain
sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer
sudo a2enmod lbmethod_byrequests

sudo systemctl restart apache2.service

#Let’s Encrypt
# ubuntu 18.04
#sudo apt-get update
#sudo apt-get install -y software-properties-common
#sudo add-apt-repository ppa:certbot/certbot
#sudo apt-get update
#sudo apt-get install -y python-certbot-apache 
#sudo certbot --apache certonly

#ubuntu 20.04
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --apache certonly

#sudo vim /etc/apache2/sites-enabled/000-default
#<Directory /var/www>
#Options Indexes FollowSymLinks MultiViews
#AllowOverride All
#Order allow,deny
#</Directory>

sudo systemctl restart apache2

#composer
cd ~
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# Installer verified
php -r "if (hash_file('sha384', 'composer-setup.php') === 'c31c1e292ad7be5f49291169c0ac8f683499edddcfd4e42232982d0fd193004208a58ff6f353fde0012d35fdd72bc394') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

#rdate install
sudo apt install -y rdate
/usr/bin/rdate -s time.bora.net >/dev/null 2>&1

# UTC -> KST : https://twpower.github.io/95-set-ubuntu-timezone
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

#nvm install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
nvm install node

#mongodb driver
sudo pecl install mongodb
#add the following line to your php.ini file: extension=mongodb.so
#composer require mongodb/mongodb or composer require jenssegers/mongodb
