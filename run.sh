#!/bin/env bash

if [ "$#" -ne 1 ]; then
	echo "usage: ./run.sh <directory>"
	exit 1
fi

# default to not use sudo
SUDO=""

# check docker permissions on Linux
uname -a | grep Linux > /dev/null
if [ $? -eq 0 ]; then
	echo "Detecting OS as Linux"
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

	# open in browser after delay
	sleep 2 && xdg-open http://localhost:8087 > /dev/null &
else
	uname -a | grep Darwin > /dev/null
	if [ $? -eq 0 ]; then
		echo "Detecting OS as MacOS"

		# open in browser after delay
		sleep 2 && open http://localhost:8087 > /dev/null &
	else
		echo "Unknown OS, proceed with your own knowledge"
	fi
fi

echo ""

echo "Hosting massif-visualizer with files from $1 at http://localhost:8087"

$SUDO docker run --restart=always -v $1:/data -p 8087:8080 -e USERID=$UID -e GROUPID=$GID --name=massif-visualizer-novnc tkreind/massif-visualizer-novnc:latest

$SUDO docker rm massif-visualizer-novnc
