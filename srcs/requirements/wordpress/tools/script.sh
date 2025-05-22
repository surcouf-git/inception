#!/bin/bash

sleep 5

if [ ! -f "/var/www/wordpress/wp-config-sample.php" ]; then
    echo "Installation de WordPress dans le volume..."
    wp core download --locale=fr_FR --path="/var/www/wordpress" --allow-root
    chown -R www-data:www-data /var/www/wordpress
fi

echo "Configuration de WordPress..."

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER \
                     --dbpass=$DB_PASSWORD --dbhost=mariadb:3306 --path="/var/www/wordpress"
else
    echo "wp-config.php existe déjà."
fi

php-fpm7.4 -F
