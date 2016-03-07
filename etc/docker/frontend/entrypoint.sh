#!/bin/bash

set -e

if [[ "$1" = 'shell' ]]; then
    exec /bin/bash
fi

MYUID=`stat -c "%u" .`

if [ "$MYUID" -gt '0' ]; then
    usermod -u $MYUID frontend
fi

gosu frontend "$@"
