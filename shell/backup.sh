#!/bin/bash

read -p "是否备份japp和jianai_app目录? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	DATE=`date +%Y%m%d`

	echo "正在备份japp和jianai_app目录 ..."
	# 备份japp 排除不备份的目录
	tar -czf japp_$DATE.tar.gz \
		--exclude="japp/Public"\
		--exclude="japp/m" \
		--exclude="japp/App/Runtime" \
		--exclude="japp/soft" \
		japp/

	mv japp_$DATE.tar.gz ./backup/japp_$DATE.tar.gz


	# 备份jianai_app 排除不备份的目录
	tar -czf jianai_app_$DATE.tar.gz \
		--exclude="jianai_app/Public" \
		--exclude="jianai_app/m" \
		--exclude="jianai_app/App/Runtime" \
		--exclude="jianai_app/soft" \
		jianai_app/

	mv jianai_app_$DATE.tar.gz ./backup/jianai_app_$DATE.tar.gz

	echo "备份japp 和 jianai_app成功"
else
	echo "已取消备份"
fi

echo
############################################

#删除n天前的日志文件
days=7

read -p "是否删除 japp 和 jianai_app 中$days天前的日志文件? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "正在删除日志文件 ..."

	rm_logfile()
	{
		path=$1
		dateline=$2
		#echo "$path $dateline"
		#删除名称形式为 1513233530-17_12_14.log 的文件
		for file in `ls $path | egrep '^[0-9]{10}-[0-9]{2}_[0-9]{2}_[0-9]{2}\.log$'`
		do
			#判断日志文件的日期是否小于dateline
			logtime=${file:0:10}
			logtime=`expr $logtime - $dateline`
			if [ $logtime \< 0 ]; then
				rm $path/$file
				echo "rm $path/$file"
			fi
		done

		#删除名称形式为 17_12_04.log 的文件
		for file in `ls $path | egrep '^[0-9]{2}_[0-9]{2}_[0-9]{2}\.log$'`
		do
			#判断日志文件的日期是否小于dateline
			fy=${file:0:2}
			fm=${file:3:2}
			fd=${file:6:2}
			y=`date -ud @$dateline +%y`
			m=`date -ud @$dateline +%m`
			d=`date -ud @$dateline +%d`
			#echo "$fy $fm $fd $y $m $d"

			flag=0
			if [ $fy \< $y ]; then
				flag=1
			elif [ $fy -eq $y ]; then
				if [ $fm \< $m ]; then
					flag=1
				elif [ $fm -eq $m ]; then
					if [ $fd \< $d ]; then
						flag=1
					fi
				fi
			fi

			#echo "$flag"
			if [ $flag \> 0 ]; then
				rm $path/$file
				echo "rm $path/$file"
			fi
		done
	}

	dateline=`date +%s`
	dateline=`expr $dateline - $days \* 86400`
	#echo "$dateline"
	path='/home/www/japp/App/Runtime/Logs/Home'
	rm_logfile $path $dateline
	path='/home/www/jianai_app/App/Runtime/Logs/Home'
	rm_logfile $path $dateline

	echo "删除日志文件完毕"
else
	echo "已取消删除"
fi

