#!/bin/bash

sleep 5

if [ ! -f "/var/www/wordpress/wp-config-sample.php" ]; then
	echo "moving wordpress"
	cp -r /var/www/temp_wordpress/wordpress/* /var/www/wordpress/.
fi

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	echo "connecting to database"
	wp config create	--allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_USER \
				--dbpass=$SQL_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

if ! wp core is-installed --allow-root --path='/var/www/wordpress'; then
    wp core install --allow-root \
        --url=https://localhost \
	--title="INCEPTION" \
        --admin_user=$ADMIN_WP_USER \
        --admin_password=$ADMIN_WP_PASSWORD \
        --admin_email=$ADMIN_WP_EMAIL \
        --path='/var/www/wordpress'
        
    wp user create simple_user simple@example.com \
        --role=author \
        --user_pass=$USER_PASSWORD \
        --allow-root \
        --path='/var/www/wordpress'
fi

php-fpm7.4 -F
