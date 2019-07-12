#!/bin/bash

now="$(date +'%Y-%m-%d %T')"

WORK_PATH=/app/svn_backup
SVN_PATH=/app/svn_backup/LGF

# 根据文件最后修改时间判断是否已更新
cd $WORK_PATH
date1=$(stat -c %Y "./.timestamp")
date2=$(stat -c %Y "/dump.rdb")

if [[ $date1 != $date2 ]]; then

    cd $SVN_PATH

    cp /dump.rdb ./dump.rdb

    # svn add ./*
    svn status
    svn commit -m "$now 备份"

    echo "[$now] redis数据备份，svn提交完成"
    echo

    cd $WORK_PATH
    touch /dump.rdb
    touch ./.timestamp

fi


