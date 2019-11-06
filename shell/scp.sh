
# 切换到本脚本所在的目录
cd  `dirname $0`

sql_file_name="jianai360_$(date +'%Y-%m-%d').sql"

sshpass -p 'password' scp -P 10667 root@59.175.144.11:/web/bak/$sql_file_name .

sshpass -p 'password' scp -P 10667 root@59.175.144.11:/usr/local/redis/data/dump.rdb .

yesterday_sql_file_name="jianai360_$(date --date="1	days ago" +'%Y-%m-%d').sql"

# 删除之前的sql备份，只保留今天和昨天的
for entry in `ls .|grep jianai360_`; do
	 if [ $entry != "$sql_file_name" ] && [ $entry != "$yesterday_sql_file_name" ]
	 then
		 rm $entry
	 fi
done
