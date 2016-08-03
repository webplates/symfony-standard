FROM webplates/php:5.6-fpm-node-6.3
# node sass does not support Alpine at the moment
# https://github.com/sass/node-sass/issues/1589

RUN apt-get update && apt-get install -qqy git libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libicu-dev

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) iconv mbstring mcrypt intl pdo_mysql gd

ENV BOWER_VERSION 1.7.9
ENV GULP_VERSION 1.2.2

RUN npm install -g bower@$BOWER_VERSION gulp-cli@$GULP_VERSION

ENV COMPOSER_VERSION 1.1.0
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# Install frontend dependencies
COPY package.json npm-shrinkwrap.json ./
RUN npm install

COPY bower.json .
RUN bower --allow-root install

ENV SYMFONY_ENV prod

# Production PHP configuration
COPY etc/docker/prod/app/php.ini /usr/local/etc/php/php.ini

COPY composer.json composer.lock ./
RUN composer install --prefer-dist --no-dev --no-interaction --quiet --no-autoloader --no-scripts

COPY LICENSE .
COPY bin/ bin/
COPY etc/ etc/
COPY app/ app/
COPY src/ src/
COPY var/ var/
COPY web/ web/
COPY .babelrc gulpfile.babel.js ./

# Build and cleanup
RUN set -xe \
    && composer dump-autoload --optimize \
    && composer run-script post-install-cmd \
    && gulp --env production \
    && bin/console assets:install \
    && bin/console cache:clear --no-warmup \
    && rm -rf bower_components/ \
        bower.json \
        etc/ \
        gulpfile.babel.js \
        node_modules/ \
        npm-shrinkwrap.json \
        package.json \
        var/cache/* \
        var/logs/*

VOLUME ["/var/www/html/public", "/var/www/html/var/sessions"]

COPY etc/docker/prod/app/entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
