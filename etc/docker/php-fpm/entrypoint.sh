#!/bin/bash

set -e

if [[ "$1" = 'shell' ]]; then
    exec /bin/bash
fi

MYUID=`stat -c "%u" .`

if [ "$MYUID" -gt '0' ]; then
    usermod -u $MYUID www-data
fi

if [[ "$1" = 'php-fpm' || "$1" = '' ]]; then
    exec php-fpm
fi

gosu www-data "$@"
