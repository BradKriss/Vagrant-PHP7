echo "Provisioning virtual machine..."

echo "Installing Git"
apt-get install git -y > /dev/null

echo "Installing Nginx"
apt-get install nginx -y > /dev/null

echo "Updating PHP repository"
apt-get install python-software-properties build-essential -y > /dev/null
add-apt-repository ppa:ondrej/php -y > /dev/null
apt-get update > /dev/null

echo "Installing PHP"
apt-get install php7.0 php5-dev php7.0-cli php7.0-fpm -y > /dev/null

echo "Installing PHP extensions"
apt-get install curl php7.0-curl php7.0-gd php7.0-mcrypt php7.0-mysql -y > /dev/null

echo "Configuring PHP"
cp /var/www/provision/cli-php.ini /etc/php/7.0/cli/php.ini
cp /var/www/provision/fpm-php.ini /etc/php/7.0/fpm/php.ini

echo "Installing Composer"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo "Preparing MySQL"
# debconf-utils allows the root password to be inputed as a command line argument, needed for instalistion
apt-get install debconf-utils -y > /dev/null
debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234" # CHANGE ME
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234" # CHANGE ME

echo "Installing MySQL"
apt-get install mysql-server -y > /dev/null


echo "Configuring MySQL"
cp /var/www/provision/my.cnf /etc/mysql/my.cnf
sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf # This will overwrite any changes to my.cnf made for bind-address
service mysql restart

echo "Configuring Nginx"
cp /var/www/provision/nginx_vhost /etc/nginx/sites-available/nginx_vhost > /dev/null
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-available/default
service nginx restart > /dev/null

echo "Complete!"
