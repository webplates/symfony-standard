#!/bin/bash

set -e

MYUID=`stat -c "%u" .`
MYGID=`stat -c "%g" .`

if [ "$MYUID" -gt '0' ]; then
    usermod -u $MYUID www-data
    groupmod -g $MYGID www-data
fi

if [[ "$1" = 'php-fpm' || "$1" = '' ]]; then
    exec php-fpm
fi

gosu www-data "$@"
