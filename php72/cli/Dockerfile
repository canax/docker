#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "make update / update.bash"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
#
# Use something as base image
#
FROM php:7.2-cli



#
# Get needed base tools in Debian
#
RUN apt-get update && apt-get install -y \
        ca-certificates \
        git             \
        openssh-client  \
        wget            \
        unzip           \
    && rm -rf /var/lib/apt/lists/*



#
# Install PHP extensions needed
#
RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libjpeg-dev \
		libpng-dev \
		libsqlite3-dev \
	; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install -j "$(nproc)" \
		gd \
		mbstring \
		opcache \
		mysql \
		mysqli \
		pdo_mysql \
		pdo_sqlite \
		zip \
	; \
	\
	RUN yes | pecl install xdebug \
	    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
	    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
	    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
	\
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark; \
	ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
		| awk '/=>/ { print $3 }' \
		| sort -u \
		| xargs -r dpkg-query -S \
		| cut -d: -f1 \
		| sort -u \
		| xargs -rt apt-mark manual; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*



#
# Set recommended PHP.ini settings
#  see https://secure.php.net/manual/en/opcache.installation.php
#
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini



#
# Add composer
#
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer



#
# Make workdir where to store the files
#
ARG workdir=/home/anax/repo
ARG localUser=anax
RUN useradd --create-home --shell /bin/bash $localUser \
	&& mkdir -p $workdir \
	&& chown $localUser $workdir
USER $localUser
WORKDIR $workdir
