#!/usr/bin/env bash

# default to not use sudo
SUDO=""

# check docker permissions on Linux
uname -a | grep Linux > /dev/null
if [ $? -eq 0 ]; then
	# if not root
	if [ $UID -ne 0 ]; then
		# check if user is in docker group
		id $UID | grep docker > /dev/null
		if [ $? -ne 0 ]; then
			echo "User doesn't have permissions to use docker"
			echo "Asking for sudo password"
			SUDO=sudo
		fi
	fi
fi

# check if process is running
docker ps | grep massif-visualizer-novnc > /dev/null
if [ $? -eq 0 ]; then
    $SUDO docker stop massif-visualizer-novnc > /dev/null
    $SUDO docker rm massif-visualizer-novnc > /dev/null
else
    echo "Container was not running, use ./run.sh to start"
fi
