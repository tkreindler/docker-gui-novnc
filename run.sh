#!/bin/env bash

MASSIFDIR=${1:-/tmp/massif-data}

docker run --restart=always -v $MASSIFDIR:/data -p 8080:8080 -e USERID=$UID -e GROUPID=$GID --name=massif-visualizer-novnc massif-visualizer-novnc && docker rm massif-visualizer-novnc
