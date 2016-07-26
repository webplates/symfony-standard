FROM php:5.6-fpm-alpine

RUN set -xe \
    && apk add --no-cache \
    coreutils \
    freetype-dev \
    libjpeg-turbo-dev \
    libltdl \
    libmcrypt-dev \
    libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv mbstring mcrypt intl pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

#RUN apt-get update && apt-get install -qqy git libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libicu-dev
#
#RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
#RUN docker-php-ext-install iconv mcrypt intl gd pdo pdo_mysql zip

ENV COMPOSER_VERSION 1.1.0
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

ENV SYMFONY_ENV prod

# Production PHP configuration
COPY etc/docker/prod/app/php.ini /usr/local/etc/php/php.ini

COPY bin/ bin/
COPY LICENSE composer.json composer.lock ./
COPY vendor/ vendor/
COPY app/ app/
COPY src/ src/
COPY var/ var/
COPY web/ web/

RUN composer run-script post-install-cmd
RUN chmod -R 777 var/cache/ var/logs/

VOLUME ["/var/www/html"]

COPY etc/docker/prod/app/entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
