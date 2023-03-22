#!/bin/sh

# Update apt
sudo apt update -y

# Install php
sudo apt install php-cli -y

#Install composer
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
exit $RESULT

# Upgrade software
sudo apt upgrade -y
sudo apt dist-upgrade -y

# Create Drupal Project
composer create-project drupal/recommended-project tsgwebsite

# Install Drush
composer require drush/drush