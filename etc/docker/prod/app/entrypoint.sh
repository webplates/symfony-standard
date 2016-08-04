#!/bin/sh

set -e

bin/compile
chown -R www-data. var/cache/
cp -r public/* web/

case "$1" in
    ""|"php-fpm")
        # In app stdout produces weird logs
        # See: http://stackoverflow.com/questions/36134167/why-php-fpm-prefixes-a-warning-when-writing-to-stdout
        # See: https://bugs.php.net/bug.php?id=71880&thanks=6
        # More about docker logs: https://github.com/docker/docker/issues/19616
        # Note: If you mount the log dir as a volume you might experience duplications in log messages
        tail -f var/logs/${SYMFONY_ENV}.log &
        exec php-fpm
        ;;
    "console")
        exec "bin/$@" ;;
    *)
        echo "Unallowed command"
        exit 1
        ;;
esac
