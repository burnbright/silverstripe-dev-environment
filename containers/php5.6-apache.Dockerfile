FROM php:5.6-apache-jessie

RUN apt-get update -y && apt-get install -y \
		curl \
		git-core \
		gzip \
		libcurl4-openssl-dev \
		libgd-dev \
		libjpeg-dev \
		libpng-dev \
		libldap2-dev \
		libmcrypt-dev \
		libtidy-dev \
		libxslt-dev \
		zlib1g-dev \
		libicu-dev \
		libzip-dev \
		g++ \
		openssh-client \
	--no-install-recommends && \
	rm -r /var/lib/apt/lists/*

# Install PHP Extensions
RUN docker-php-ext-configure intl && \
	docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
	docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
	docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ --with-gif-dir=/usr/include/ --with-png-dir=/usr/include/ && \
	docker-php-ext-install -j$(nproc) \
		bcmath \
		intl \
		gd \
		ldap \
		mysqli \
		pdo \
		pdo_mysql \
		soap \
		xsl \
		zip \
		mcrypt

COPY ./php.ini /usr/local/etc/php/

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php --install-dir=/usr/bin --filename=composer && \
	php -r "unlink('composer-setup.php');"

RUN echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf && \
	echo "date.timezone = Pacific/Auckland" > /usr/local/etc/php/conf.d/timezone.ini && \
	a2enmod rewrite expires remoteip cgid && \
	usermod -u 1000 www-data && \
	usermod -G staff www-data

# Install PECL Extensions
RUN pecl install zip

# XDebug
# TODO: figure out how to install for php 5.6
# RUN pecl install xdebug
# RUN XDEBUG_INI=/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
# 	docker-php-ext-enable xdebug && \
# 	sed -i '1 a xdebug.remote_autostart=1' $XDEBUG_INI && \
# 	sed -i '1 a xdebug.remote_mode=req' $XDEBUG_INI && \
# 	sed -i '1 a xdebug.remote_handler=dbgp' $XDEBUG_INI && \
# 	sed -i '1 a xdebug.remote_host=127.0.0.1' $XDEBUG_INI && \
# 	sed -i '1 a xdebug.remote_connect_back=0' $XDEBUG_INI && \
# 	sed -i '1 a xdebug.remote_port=9000' $XDEBUG_INI && \
# 	sed -i '1 a xdebug.remote_enable=1' $XDEBUG_INI && \
# 	sed -i '1 a xdebug.remote_log=/var/log/xdebug.log' $XDEBUG_INI

RUN touch /var/log/xdebug.log && \
	(. "$APACHE_ENVVARS" && \
		chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" /var/log/xdebug.log)

COPY ./_ss_environment.php /var/www/_ss_environment.php
