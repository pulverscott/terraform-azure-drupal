# Terraform Azure Drupal

## Information
* Deploys and configures Ubuntu 22.04LTS Virtual machine
* Deploys and configures Azure Flexible Database Server for MySQL
* Configures LEMP web server
* Deploy one or many Drupal websites


## Deploy one or multiple websites after Terraform deploy

### Change Terraform code
* Add new database to `mysql-fs-db.ft` file and deploy

### Create Nginx Virtual host
* `sudo vi /etc/nginx/sites-available/websitename` Copy websitename file and update top 2 variables
* `sudo ln -s /etc/nginx/sites-available/websitename /etc/nginx/sites-enabled/`
* `sudo systemctl restart nginx`

### Create Drupal Project
* `cd /var/www/html`
* `composer create-project drupal/recommended-project websitename`

### Navigate to site! Don't forget to update your DNS to point to the virtual machine IP address

## Composer Extras
* `composer global require drush/drush`

## Addition Drupal configuration
* SSL database conneciton is turned off by default, this should be turned on by uploading the SSL certificate Azure gives you to the server and updating settings.php file in `/var/www/html/websitename/web/sites/default`
* Trusted Host settings can also be enabled from the same file

## Credits
* https://learn.microsoft.com/en-us/azure/mysql/flexible-server/quickstart-create-terraform?tabs=azure-cli
* https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform
* https://linuxiac.com/how-to-install-nginx-mariadb-php-on-ubuntu-22-04-lts/
* https://www.howtoforge.com/tutorial/debian-nginx-drupal/
* https://www.nginx.com/resources/wiki/start/topics/recipes/drupal/