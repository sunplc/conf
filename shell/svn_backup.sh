#!/bin/bash

now="$(date +'%Y-%m-%d %T')"

SVN_PATH=/app/svn_backup/LGF
WORKPATH=/app/AGT_ONLINE

DBUSER='root'
DBPASSWD=''
DATABASE=''

echo '正在备份...'

cd $WORKPATH

DIR=AGT_PLM
tar -czf $DIR.tar.gz \
    --exclude="$DIR/public/code" \
    $DIR/
mv $DIR.tar.gz $SVN_PATH

DIR=AGT_GAME_SERVER
tar -czf $DIR.tar.gz \
    --exclude="$DIR/bin/log" \
    $DIR/
mv $DIR.tar.gz $SVN_PATH

DIR=CPM_GAME_ONLINE
tar -czf $DIR.tar.gz \
    $DIR/
mv $DIR.tar.gz $SVN_PATH

# exit


# 切换到svn工作目录
cd $SVN_PATH

cp /dump.rdb ./dump.rdb

mysqldump --user=$DBUSER --password=$DBPASSWD --databases $DATABASE | \
gzip > ./$DATABASE.sql.gz

echo '压缩目录并复制完成'

# svn add ./*
svn status
svn commit -m "$now 备份"

echo "[$now] svn 提交完成"
echo

