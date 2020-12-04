#!/bin/bash
version=1.0.0

# 判断工作区是否为 clean 状态，不是的话直接退出
function validWorkingTree()
{
	if [ $(git status -s | wc -l) != 0 ]; then
		echo "you have uncommitted changes,please make sure your working tree is clean..."
		exit 1;
	fi
}

function rename_remote()
{
	validWorkingTree
	read -p "enter remote branch name: " oldBranchName
	read -p "enter new branch name: " newBranchName
	echo "start renaming..."

	count=$(git branch | grep $oldBranchName | wc -l)
	if [ $count == 0 ];then
		git checkout -b $oldBranchName origin/$oldBranchName
		# 分支不存在
		if [ $? != 0 ];then
			echo "branch:$oldBranchName do not exist,please check it..."
			echo "fail"
			exit 1
		fi
	fi

	# git pull 有可能发生冲突，不冲突才执行剩余的操作
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

# 需要在 git 仓库下执行该脚本
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