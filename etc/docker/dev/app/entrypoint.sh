#!/bin/bash

set -e

CUSER="www-data"
MYUID=`stat -c "%u" .`

if [[ "$MYUID" -gt '0' && "$MYUID" != `id -u ${CUSER}` ]]; then
    usermod -u ${MYUID} ${CUSER}
fi

 if [ -z "$DOCKERHOST" ]; then
     DOCKERHOST=`ip route ls | grep ^default |awk '/default/ { print  $3}'`
fi

case "$1" in
    "root")
        exec /bin/bash ;;
    "shell")
        gosu ${CUSER} "/bin/bash" ;;
    "console")
        gosu ${CUSER} php -d memory_limit=-1 /var/www/bin/console "$@" ;;
    "php-fpm")
        exec env XDEBUG_CONFIG="remote_host=$DOCKERHOST" php-fpm ;;
    "")
        exec env XDEBUG_CONFIG="remote_host=$DOCKERHOST" php-fpm ;;
    *)
        gosu ${CUSER} "$@" ;;
esac
