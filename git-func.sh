#!/bin/bash

<<'COMMENT'
知识点：
read
git初始化
basename
COMMENT
git-init-origin(){
    read -p "Input passwd:" -s passwd
    if [[ -z ${passwd} ]];then
        echo
        echo "passwd is null"
        return
    fi
    projname=$(basename `pwd`)
    git remote rm origin
    git remote add origin https://chuanqingli:${passwd}@github.com/chuanqingli/${projname}.git
}

