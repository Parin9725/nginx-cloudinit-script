#I have Tested this script on ubuntu 16.04
#!/bin/bash
sudo apt-get update
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
sudo apt-get install nginx -y
sudo apt-get install php7.2 -y
sudo apt-get install php7.2-fpm  php7.2-mysql -y
#Mysql root password is 111
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 111'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 111'
sudo apt-get -y install mysql-server
#Edit Nginx Deafult Site
sudo sed -i '39s/index index.html index.htm index.nginx-debian.html;/index index.php index.html index.htm index.nginx-debian.html;/' /etc/nginx/sites-available/default
sudo sed -i '47i   location ~ \.php$ {' /etc/nginx/sites-available/default
sudo sed -i '48i        include snippets/fastcgi-php.conf;' /etc/nginx/sites-available/default
sudo sed -i '49i        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;' /etc/nginx/sites-available/default
sudo sed -i '50i}' /etc/nginx/sites-available/default
#Add php file in /var/www/html
echo "<?php phpinfo(); ?>" | sudo tee --append /var/www/html/index.php
sudo service nginx reload
