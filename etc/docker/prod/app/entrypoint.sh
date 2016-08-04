#!/bin/sh

set -e

bin/console cache:clear
chmod -R 777 var/cache/ var/logs/
cp -r web/* var/public/

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
