#!/bin/bash

set -e

CUSER="www-data"
MYUID=`stat -c "%u" .`

if [[ "$MYUID" -gt '0' && "$MYUID" != `id -u ${CUSER}` ]]; then
    usermod -u ${MYUID} ${CUSER}
fi

case "$1" in
    "root")
      exec /bin/bash ;;
    "shell")
      gosu ${CUSER} "/bin/bash" ;;
    "php-fpm")
      exec php-fpm ;;
    "")
      exec php-fpm ;;
    *)
      gosu ${CUSER} "$@" ;;
esac
