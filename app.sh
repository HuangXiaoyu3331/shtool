#!/bin/bash
version=1.1.0

appName=${!#}
basePath=/Users/huangxy/work/docker

function usage()
{
	echo "Usage: $0 {command} {appName}"
	echo "Node: {command} should be on of the command in docker-compose"
	echo "Example: $0 up mysql8"
	exit 1
}

if [[ $# -ne 2 ]]; then
	usage
fi

cd $basePath/$appName && docker-compose $1