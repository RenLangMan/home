#!/bin/bash
cd /data/vdb1/dockeroot/git_repos/home
msg=$1
if [ -n "$msg" ]; then
   git add -A
   git commit -m"${msg}"
   git pull
   git status
   echo "完成add、commit、pull，别忘了push"
else
    echo "请添加注释再来一遍"
fi
