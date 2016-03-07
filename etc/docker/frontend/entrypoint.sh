#!/bin/bash

set -e

MYUID=`stat -c "%u" .`

if [[ "$MYUID" -gt '0' && "$MYUID" != `id -u frontend` ]]; then
    usermod -u $MYUID frontend
fi

if [[ "$1" = 'root' ]]; then
    exec /bin/bash
fi

if [[ "$1" = 'shell' ]]; then
    gosu frontend "/bin/bash"
fi

gosu frontend "$@"
