FROM	debian:bullseye

RUN	apt update -y && apt upgrade -y && apt-get install wget -y 
RUN	apt install -y php-fpm && apt install -y php-mysql && apt install -y mariadb-client

RUN	mkdir -p /run/php /var/log/php

RUN	mkdir temp_wordpress
RUN	wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www/temp_wordpress
RUN	cd /var/www/temp_wordpress && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/temp_wordpress/wordpress

COPY	conf/www.conf /etc/php/7.4/fpm/pool.d/.
RUN	chmod a+rx /etc/php/7.4/fpm/pool.d/www.conf	

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/local/bin/wp

EXPOSE	9000

COPY	tools/wp_config.sh .
RUN	chmod a+rx wp_config.sh

CMD	["./wp_config.sh"]
