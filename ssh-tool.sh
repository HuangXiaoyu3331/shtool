#!/bin/bash
version=1.0.0

conf_file=~/.ssh/config

function get_hosts()
{
	echo `sed -n 's/Host \(.*\)/\1/p' $conf_file`
}

echo "请输入想要登陆的服务器编号:"
select host in `get_hosts`
do
	ssh $host
	break
done
