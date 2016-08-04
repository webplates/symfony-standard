#!/bin/sh

set -e

bin/console cache:clear
chmod -R 777 var/cache/ var/logs/
cp -r public/* web/

case "$1" in
    "php-fpm")
        exec php-fpm ;;
    "")
        exec php-fpm ;;
    "console")
        exec "bin/$@" ;;
    *)
        echo "Unallowed command"
        exit 1
        ;;
esac
