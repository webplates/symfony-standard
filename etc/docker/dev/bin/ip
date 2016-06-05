#!/bin/bash

CONTAINER="$1"
PROJECT=$(echo ${PWD##*/} | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]')

echo "$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{.Config.Image}}' `docker ps | grep ${PROJECT}_${CONTAINER} | awk '{print $1}'`)"
