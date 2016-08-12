FROM webplates/symfony-php:5.6-fpm
# node sass does not support Alpine at the moment
# https://github.com/sass/node-sass/issues/1589

ENV BOWER_VERSION=1.7.9 GULP_VERSION=1.2.2 NPM_CONFIG_LOGLEVEL=warn

RUN set -xe \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -qqy nodejs build-essential \
    && npm install -g bower@$BOWER_VERSION gulp-cli@$GULP_VERSION --silent

# Install frontend dependencies
COPY package.json npm-shrinkwrap.json ./
RUN npm install --silent

COPY bower.json .
RUN bower install --allow-root --silent

# Replace this with a proper PHP ini config
RUN echo "[PHP]\n\ndate.timezone = UTC" > /usr/local/etc/php/php.ini

COPY composer.json composer.lock ./
RUN composer install --prefer-dist --no-dev --no-autoloader --no-scripts --no-interaction --quiet

COPY . .

# Build and cleanup
RUN set -xe \
    && composer dump-autoload --optimize \
    && composer run-script post-install-cmd \
    && gulp --env production \
    && bin/console assets:install \
    && mv web/ public/ \
    && bin/console cache:clear --no-warmup \
    && rm -rf .babelrc \
        bower_components/ \
        bower.json \
        etc/ \
        gulpfile.babel.js \
        node_modules/ \
        npm-shrinkwrap.json \
        package.json \
        var/cache/* \
        var/logs/* \
    && mkdir -p var/sessions/ var/uploads/ \
    && chmod -R 777 var/sessions/ var/uploads/

VOLUME ["/app/web", "/app/var/sessions", "/app/var/uploads"]

COPY etc/docker/prod/app/entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
