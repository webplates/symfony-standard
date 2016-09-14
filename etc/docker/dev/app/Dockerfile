FROM webplates/symfony-php-dev:7.0-fpm

ARG USE_XDEBUG=no

RUN set -ex \
    && if [ $USE_XDEBUG = "yes" ]; then \
        pecl install xdebug && docker-php-ext-enable xdebug; \
        echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini; \
        echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini; \
        echo "xdebug.remote_connect_back=off" >> /usr/local/etc/php/conf.d/xdebug.ini; \
    fi

COPY php.ini /usr/local/etc/php/conf.d/custom.ini
COPY entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
