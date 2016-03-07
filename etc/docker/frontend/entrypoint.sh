#!/bin/bash

set -e

MYUID=`stat -c "%u" .`
MYGID=`stat -c "%g" .`

if [ "$MYUID" -gt '0' ]; then
    usermod -u $MYUID frontend
    groupmod -g $MYGID frontend
fi

gosu frontend "$@"
