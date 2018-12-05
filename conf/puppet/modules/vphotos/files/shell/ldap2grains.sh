#!/bin/bash
# 转换 ldap 数据到 salt grains
# hmy@v.photos 2017.07.25  
#
# example:
#dn: cn=10.3.16.37,ou=nginxgalleryimg,ou=nginx,ou=hd1,ou=datacenter,dc=vphotos,dc=cn
#VPhotosrolelist: base
# 包括下面这些role
# dn里面的ou,除了 datacenter 
# VPhotosrolelist 里面的内容
# 所以role列表是:
# nginxgalleryimg   nginx   hd1   base


export COLOR_NC='\e[0m' # No Color
export COLOR_GREEN='\e[0;32m'
export COLOR_RED='\e[0;31m'
SRV="10.3.16.32"
LDPASS="VPhot0s"

while getopts 'r:h:f' opt;do
        case $opt in
        f)
        UPDATE="yes";;
        r)
        RLIST="$OPTARG";;
        h)
        GIP="$OPTARG";;
        *)
        ;;
esac
done


if [ -z $RLIST ];then

LIP=$(hostname -I|tr ' ' '\n' |grep -v -e '127.0.0'|head -n 1)

if [ -z $GIP ];then
  IP=$LIP
else
  IP=$GIP
fi

# 角色和角色定义
ldapsearch  -H ldap://$SRV/ -LLL -D 'cn=hmy,dc=vphotos,dc=cn' -w $LDPASS -b 'ou=datacenter,dc=vphotos,dc=cn'  "(&(cn=${IP})(objectClass=VPhotosHost))" VPhotosrolelist |perl -p0e 's/\n //g' >/tmp/dc.ldif
R1=$(grep "cn=$IP," /tmp/dc.ldif|tr ',' '\n'|grep "^ou"|grep -v -e datacenter|sed 's/ou=//'|tr '\n' ','|sed 's/,$//')
[ -z $R1 ]&&{ echo  -e "${COLOR_RED}没找到 $IP 的定义!${COLOR_NC}" ; exit 1 ; }
R2=$(grep "^VPhotosrolelist:" /tmp/dc.ldif|awk '{print $2}'|sed -e 's/\[//' -e 's/\]//')
RLIST=$(echo  "$R1,$R2"|tr ',' '\n'|sort|uniq|tr '\n' ','|sed -e 's/^,//' -e 's/,$//')
	
fi
cat <<EOF >/tmp/vphotos.conf
---
# 自动从openlodap 生成的数据，不要手工修改!
# $(date)
grains:
  roles: [$RLIST]
EOF

> /tmp/roles.list
# 角色具体定义
RLIST2=$(echo $RLIST|sed -e 's/,/ /g')
for i in $(echo $RLIST2);do
	echo "  # $i define" >> /tmp/roles.list
	ldapsearch  -H ldap://$SRV/ -LLL -D 'cn=hmy,dc=vphotos,dc=cn' -w $LDPASS -b 'ou=role,dc=vphotos,dc=cn'  "(&(cn=$i)(objectClass=VPhotosRole))" |perl -p0e 's/\n //g'|grep "^VPhotosGrains"|sed -e 's/^VPhotosGrains:/ /' -e 's/^ */  /' -e 's/:/: /' -e 's/: */: /' >>/tmp/roles.list
done 

L1=$(grep -v "#"  /tmp/roles.list|wc -l)
L2=$(grep -v "#" /tmp/roles.list|awk '{print $1}'|sort|uniq|wc -l)

if [ $L1 -ne $L2 ];then
	echo -e "${COLOR_RED}有重复定义，检查ldap"
	grep -v "#" /tmp/roles.list|awk '{print $1}' |sort|uniq -c|sort -g|awk '{ if ($1 != 1) print $0}'
	echo -e "${COLOR_NC}"
	exit 1
fi

cat /tmp/roles.list >> /tmp/vphotos.conf
sed -i  -e '/\[.*\]/ s/,/\n    - /g'   /tmp/vphotos.conf
sed -i  -e 's/\[/\n    - /'  -e 's/\]//'  /tmp/vphotos.conf
sed -i 's/ *$//' /tmp/vphotos.conf
cat /tmp/vphotos.conf

if [ "x$UPDATE" == "xyes" ];then
  cp  /tmp/vphotos.conf   /etc/vphotos.conf -f
  if [ $? -eq 0 ];then
    echo -e "\n\n==================================\nupdate /etc/vphotos.conf ${COLOR_GREEN}SUCCESSFUL!${COLOR_NC}\n" >&2
  else
    echo -e "\n\n==================================\nupdate /etc/vphotos.conf ${COLOR_RED}FAILED!${COLOR_NC}\n" >&2
  fi
fi
