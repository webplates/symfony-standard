#!/bin/bash

set -e

CUSER="frontend"
MYUID=`stat -c "%u" .`

if [[ "$MYUID" -gt '0' && "$MYUID" != `id -u ${CUSER}` ]]; then
    usermod -u ${MYUID} ${CUSER}
fi

case "$1" in
    "build")
        exec gulp build ;;
    "watch")
        exec gulp watch ;;
    *)
        exec "$@" ;;
esac
