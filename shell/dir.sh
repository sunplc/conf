#!/bin/bash

now="$(date +'%Y-%m-%d %T')"

SVN_PATH=/app/svn_backup/LGF
WORKPATH=/app/AGT_ONLINE

DB_USER='root'
DB_PASSWD='password
DATABASE=cpm_agent

echo '开始备份目录...'

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

mysqldump --user=$DB_USER --password=$DB_PASSWD --databases $DATABASE | \
gzip > ./$DATABASE.sql.gz

echo "[$now] 压缩目录并且复制完成"
echo


