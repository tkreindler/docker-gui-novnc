#!/usr/bin/env bash

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

	# define open command
	OPEN=xdg-open
else
	uname -a | grep Darwin > /dev/null
	if [ $? -eq 0 ]; then
		echo "Detecting OS as MacOS"

		# define open command
		OPEN=open
	else
		echo "Unknown OS, proceed with your own knowledge"
	fi
fi

echo ""

# check if process is running
docker ps | grep massif-visualizer-novnc > /dev/null
if [ $? -eq 0 ]; then
    echo "Container is already running, use ./stop.sh to stop it"
	exit 1
fi

$SUDO docker run -d --restart=always -v $1:/data -p 127.0.0.1:8087:8080 -e USERID=$UID -e GROUPID=$GID --name=massif-visualizer-novnc tkreind/massif-visualizer-novnc:latest

if [ $? -ne 0 ]; then
	exit $?
fi

echo "Hosting massif-visualizer with files from $1 at http://localhost:8087"
echo "Run ./stop.sh to quit"

# open the browser after a delay
sleep 2 && $OPEN http://localhost:8087 > /dev/null
