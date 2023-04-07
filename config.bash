#!/bin/sh

# Update
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get upgrade -y

# Install Nginx
sudo apt-get install nginx -y

# Install dependencies
sudo apt-get install php-fpm php-mysql php-gd php-cli php-curl php-mbstring php-zip php-opcache php-xml php-apcu -y

# Install composer
sudo apt-get install composer -y

# Change html permissions
sudo chown www-data:www-data /var/www/html 
sudo chmod 775 /var/www/html

# Add user to www-data group
sudo adduser azureuser www-data