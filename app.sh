#!/bin/bash
version=1.0.0

appName=$2
basePath=/Users/huangxy/work/docker

function start()
{
	cd $basePath/$appName
	docker-compose up -d
}

function stop()
{
	cd $basePath/$appName
	docker-compose stop
}

function usage()
{
	echo "Usage: $0 {start|stop} {appName}"
	echo "Example: $0 start mysql8"
	exit 1
}

case $1 in
	start)
	start;;

	stop)
	stop;;

	*)
	usage;;
esac
