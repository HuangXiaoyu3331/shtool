#!/bin/bash
version="1.0.0"

str=$2

function encode()
{
	echo $str | base64
}

function decode()
{
	echo $str | base64 -d
}

function usage()
{
	echo "Usage: $0 {encode|decode} {encodeStr|decodeStr}"
	echo "Example: $0 encode 123456"
	exit 1
}

case $1 in
	encode)
	encode;;

	decode)
	decode;;

	*)
	usage;;
esac
