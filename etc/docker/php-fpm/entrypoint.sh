#!/bin/bash

set -e

MYUID=`stat -c "%u" .`

if [[ "$MYUID" -gt '0' && "$MYUID" != `id -u www-data` ]]; then
    usermod -u $MYUID www-data
fi

if [[ "$1" = 'root' ]]; then
    exec /bin/bash
fi

if [[ "$1" = 'shell' ]]; then
    gosu www-data "/bin/bash"
fi

if [[ "$1" = 'php-fpm' || "$1" = '' ]]; then
    exec php-fpm
fi

gosu www-data "$@"
