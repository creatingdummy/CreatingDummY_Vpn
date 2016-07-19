#!/bin/bash
echo 'AUTOSCRIPT OCS PANEL'
echo 'UPDATE REPOSITORY'
apt-get update
clear
echo 'AUTOSCRIPT BY CreatingDummY'
clear
echo 'INSTALL PACKAGE'
apt-get --assume-yes install libxml-parser-perl
apt-get --assume-yes install nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt
apt-get --assume-yes install mysql-server
mysql_secure_installation
clear
echo 'REMOVE AND ADD NEW OBJECT'
useradd -m vps
mkdir -p /home/vps/public_html
chown -R mysql:mysql /var/lib/mysql/
chmod -R 755 /var/lib/mysql/
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
curl https://raw.githubusercontent.com/creatingdummy/OCS-PANEL/master/nginx.conf > /etc/nginx/nginx.conf
curl https://raw.githubusercontent.com/creatingdummy/OCS-PANEL/master/vps.conf > /etc/nginx/conf.d/vps.conf
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
clear
#echo 'CREATE OCS PANEL'
#apt-get --assume-yes install git
#cd /home/vps/public_html
#git init
#git remote add origin https://github.com/adenvt/OcsPanels.git
#git pull origin master
#clear
echo 'CREATE DATABASE'
mysql --verbose --user=root --password --execute="CREATE DATABASE IF NOT EXISTS OCS_PANEL"
echo 'GIVE PERMISSION'
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
clear
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
php5enmod mcrypt
service php5-fpm restart
service nginx restart
rm -r /root/ocs
clear
rm -rf ~/.bash_history && history -c
echo "             OCS PANEL"
echo "----------------------------------------"
echo "      PLEASE REBOOT TAKE EFFECT !"
echo "========================================"
echo "        SERVICE CONTACT NUMBER"
echo "            016-4968761"
echo "========================================"
rm -f /root/OCS