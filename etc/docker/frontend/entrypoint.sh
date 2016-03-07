#!/bin/bash

set -e

MYUID=`stat -c "%u" .`

if [ "$MYUID" -gt '0' ]; then
    usermod -u $MYUID frontend
fi

gosu frontend "$@"
