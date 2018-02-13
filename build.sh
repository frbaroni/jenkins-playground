#!/bin/sh
export HOST_DOCKER_GROUPID=`cat /etc/group | grep docker | cut -d: -f3`
echo "HOST_DOCKER_GROUPID = $HOST_DOCKER_GROUPID"
docker-compose build
