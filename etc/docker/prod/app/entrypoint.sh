#!/bin/sh

set -e

bin/console cache:clear
chown -R www-data. var/cache/
cp -r public/* web/

case "$1" in
    ""|"php-fpm")
        # Logging to stdout produces weird errors
        # See: http://stackoverflow.com/questions/36134167/why-php-fpm-prefixes-a-warning-when-writing-to-stdout
        # See: https://bugs.php.net/bug.php?id=71880&thanks=6
        # More about docker logs: https://github.com/docker/docker/issues/19616
        # Why truncate: http://serverfault.com/questions/599103/make-a-docker-application-write-to-stdout
        # And: http://stackoverflow.com/a/23924383/3027614
        umask 0 && truncate -s0 var/logs/${SYMFONY_ENV}.log
        tail --pid $$ -n0 -F var/logs/* &
        exec php-fpm
        ;;
    "console")
        exec "bin/$@" ;;
    *)
        echo "Unallowed command"
        exit 1
        ;;
esac
