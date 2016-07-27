#!/bin/sh

set -e

bin/console cache:clear
chmod -R 777 var/cache/ var/logs/
rm -rf public/*
mv web/* public/

case "$1" in
    "php-fpm")
        exec php-fpm ;;
    "")
        exec php-fpm ;;
    "migrate")
        exec bin/console doctrine:migrations:migrate ;;
    *)
        exec "$@" ;;
esac
