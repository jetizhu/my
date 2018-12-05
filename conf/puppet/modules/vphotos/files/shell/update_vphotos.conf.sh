#!/bin/bash
#
#
#  hmy@v.photos
#  2017.7.14
#  交互式配置/etc/vphotos.conf , salt grains 文件，yaml 格式。
#  TODO,增加参数配置方式, 如果带参数 -x 就不用交互式

[ -d /opt/salt/etc ]
if [ $? -ne 0 ];then
  echo "还没有安装salt"
  exit 0
fi

DC=""
ROLES=""
NGX_SITES=""
NGX_MAINCONF=""
NGX_LOG_TYPE=""



display_menu(){
	path=$1
	listtype=$2
	title=$3
	msg=$4
	rest=$(whiptail --noitem --title $title --$listtype "$msg" 20 80 $(/bin/ls $path |wc -l) \
	$(/bin/ls -l $path |sed -e 's/.sls$//' -e 's/.sh$//' -e '1d'|awk '{print $NF" OFF"}') 3>&1 1>&2 2>&3)
	rr=$(echo $rest|sed 's/ /,/g')
	eval $5="$rr"
}

display_menu2(){
	path=$1
	cd $path
	listtype=$2
	title=$3
	msg=$4
	rest=$(whiptail  --title $title --$listtype "$msg" 20 80 $(/bin/ls $path |wc -l) \
	$(grep "info:" * |sed  's/:#info://'|sed -e 's/.sls//' -e 's/.sh//') 3>&1 1>&2 2>&3)
	rr=$(echo $rest|sed 's/ /,/g')
	eval $5="$rr"
	cd - >/dev/null
}



update_main(){
cat <<EOF  >/tmp/vphotos.conf
grains:
  datacenter: ${DC}
  roles:
EOF
}


update_main_conf(){
	whiptail --defaultno --yesno "update to /etc/vphotos.conf ?" 8 40
	if [ $? -eq 0 ];then
  		cp /etc/vphotos.conf /root/vphotos.conf.$(date +%s)
  		cp /tmp/vphotos.conf /etc/vphotos.conf
	fi
	cat /tmp/vphotos.conf
}
# main

# 1. 选择机房和角色
display_menu2 /opt/pillar/dc radiolist 机房 选择机房 DC
display_menu2 /opt/pillar/roles.shell checklist 角色 选择角色 ROLES

# 2. 数据正确性检查
if [ -z $DC  ]||[ -z $ROLES ];then
	whiptail --msgbox "没有选择机房或者角色，退出!" 20 60
fi

# 3. 主配置文件
update_main


# 4.  读取 /opt/pillar/roles.shell/ 目录下的角色设置脚本，自动扩展
#    

for i in `echo "$ROLES"|tr ',' '\n'`;do
		. /opt/pillar/roles.shell/${i}.sh
done



# 5. 更新生成环境配置文件
update_main_conf

exit 0

