# Use something as base image
FROM php:7.0-apache

# Enable apache modules
RUN a2enmod rewrite expires cgi setenvif

# Install PHP extensions needed
RUN set -ex \
	&& buildDeps=' \
		libjpeg62-turbo-dev \
		libpng12-dev \
		libpq-dev \
	' \
	&& apt-get update && apt-get install -y --no-install-recommends $buildDeps && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd \
		--with-jpeg-dir=/usr \
		--with-png-dir=/usr \
	&& docker-php-ext-install -j "$(nproc)" gd mbstring opcache pdo pdo_mysql pdo_pgsql zip \
	&& apt-mark manual \
		libjpeg62-turbo \
		libpq5 \
	&& apt-get purge -y --auto-remove $buildDeps

# Set recommended PHP.ini settings
#  see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Make w workdir where to store the files
RUN mkdir -p /app
WORKDIR /app

# Get php.info for debugging
#RUN echo '<?php phpinfo();' > /var/www/html/phpinfo.php

# Add composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set Timezone for PHP
#ENV TZ=Europe/Stockholm
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
# 	&& echo $TZ > /etc/timezone
#RUN echo "date.timezone = $TZ" > /usr/local/etc/php/conf.d/timezone.ini

# Avoid warning from Apache on
# Could not reliably determine the server's fully qualified domain name,
RUN echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf \
	&& a2enconf fqdn
