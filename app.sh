#!/bin/bash
version=1.1.1

appName=${!#}
basePath=/Users/huangxy/work/docker

function show_all_app()
{
	ls $basePath
}

function usage()
{
	echo "Usage: $0 {command} {appName}"
	echo "Node: {command} should be on of the command in docker-compose"
	echo "Example: $0 up mysql8"
	exit 1
}

function exec()
{
	if [[ $# -lt 2 ]]; then
		usage
	fi
	cd $basePath/$appName
	echo "run command: docker-compose ${@:1:`expr $# - 1`}"
	docker-compose ${@:1:`expr $# - 1`}
}

function enterDockerContainer()
{
	container=$2
	docker exec -it $container /bin/bash
}

case $1 in
	-l )
	show_all_app;;

	enter )
		enterDockerContainer $@;;
	* )
	exec $@;;
esac
