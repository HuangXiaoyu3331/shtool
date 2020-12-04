#!/bin/bash
version=1.0.0

function rename_remote()
{
	read -p "enter remote branch name: " oldBranchName
	read -p "enter new branch name: " newBranchName
	echo "start renaming..."

	count=$(git branch | grep $oldBranchName | wc -l)
	if [ $count == 0 ];then
		git checkout -b $oldBranchName origin/$oldBranchName
		if [ $? != 0 ];then
			echo "branch:$oldBranchName do not exist,please check it..."
			echo "fail"
			exit 1
		fi
	fi

	if git pull ; then
		git push --delete origin $oldBranchName
		git branch -m $oldBranchName $newBranchName
		git push origin $newBranchName
		git branch --set-upstream-to=origin/$newBranchName $newBranchName
		echo "done"
	fi	
}

function usage()
{
	echo "Usage: $0 {rename}"
    echo "Example: $0 rename"
    exit 2
}

if [ $(ls -al | grep '\.git' | wc -l) == 0 ]; then
	echo "the current path is not the git repository,please check it..."
	exit 3
fi

case $1 in
	rename )
		rename_remote;;
	* )
		usage;;
esac