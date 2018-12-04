#!/bin/bash

<<'COMMENT'
知识点：
read
git初始化
basename
COMMENT

# 读取密码
git-read-passwd(){
    read -p "输入git密码:" -s passwd
    if [[ -z ${passwd} ]];then
        echo
        echo "输入git密码不能为空!"
        exit
    fi
}

# 读取密码
git-read-projname(){
    read -p "输入要下载的git项目名称:" -e projname
    if [[ -z ${projname} ]];then
        echo
        echo "项目名称不能为空!"
        exit
    fi
}

# 重置origin
git-init-origin(){
    git-read-passwd
    projname=$(basename `pwd`)
    git remote rm origin
    git remote add origin https://chuanqingli:${passwd}@github.com/chuanqingli/${projname}.git
}

# git clone
git-clone(){
    git-read-projname
    # echo $projname
    git clone https://github.com/chuanqingli/${projname}.git
}

$1
