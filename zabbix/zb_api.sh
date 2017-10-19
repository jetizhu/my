#!/bin/bash
USER=guest
PASSWORD=
SALTPATH=/opt/salt/zabbix-agent/script
ZabbixFile=/etc/zabbix
URL=http://monitori.vphotos.cn/zabbix/api_jsonrpc.php
HEADER=Content-Type:application/json
LOGIN='{"jsonrpc":"2.0","method":"user.login","params":{"user":"Admin","password":"zabbix"},"id":1,"auth":null}'
IP=`ifconfig  | grep 'inet addr:' | grep -v '127.0.0.1' |awk '{print $2}'  |sed 's/addr://g' |awk NR==1`
HostName=`hostname`
KEY=`/usr/bin/curl -XPOST -s -H $HEADER -d $LOGIN $URL |jq . |grep result|awk '{print$2}'|sed 's/[",]//g'`
#echo $KEY
IP=`ifconfig  | grep 'inet addr:' | grep -v '127.0.0.1' |awk '{print $2}'  |sed 's/addr://g' |awk NR==1`
SaltTemplate=`salt-call --local grains.get zbtemplates |grep -v local |sed 's/-//g' |sed 's/^\s*//g'`
HOSTLIST="{\"jsonrpc\":\"2.0\",\"method\":\"host.get\",\"params\":{\"output\":[\"hostid.ip\"],\"selectInterfaces\":[\"interfaceid\",\"ip\"]},\"id\":2,\"auth\":\"$KEY\"}"
HOSTIDLIST="{\"jsonrpc\":\"2.0\",\"method\":\"host.get\",\"params\":{\"output\":\"extend\",\"filter\":{\"host\":\"$IP\"}},\"auth\":\"$KEY\",\"id\":1}"
HOSTID=`/usr/bin/curl -XPOST -s -H $HEADER -d $HOSTIDLIST $URL |jq ".result[].hostid"`
Host=`/usr/bin/curl -XPOST -s -H $HEADER -d $HOSTIDLIST $URL |grep $IP |wc -l`
cd $ZabbixFile
 if [ $Host == 0 ]; then
    sed -i "/auth/ s/:.*/\:  \"$KEY\",/" templateget.txt
    SaltTemplate=`salt-call --local grains.get zbtemplates |grep -v local |sed 's/-//g' |sed 's/^\s*//g' |while read -r line; do echo "\"$line\"";done |tr '\n' ','|sed 's/,$//'`
    sed -i "8s/^.*/$SaltTemplate/" templateget.txt
    TemplateID=`/usr/bin/curl -XPOST -s -H $HEADER -d@'templateget.txt' $URL |jq ".result[].templateid"`
    sed -i "/auth/ s/:.*/\:  \"$KEY\",/" hostcreate.txt
    sed -i "/\"host\"/ s/:.*/\:  \"$IP\",/" hostcreate.txt
    sed -i "/\"name\"/ s/:.*/\:  \"$HostName\",/" hostcreate.txt
    sed -i "/\"ip\"/ s/:.*/\:  \"$IP\",/"  hostcreate.txt
    TemplateID2=`for i in $TemplateID ;do echo "{\"templateid\":$i}";done |tr '\n' ','|sed 's/,$//'` 
    sed -i "21s/^.*/$TemplateID2/" hostcreate.txt
    /usr/bin/curl -XPOST -s -H $HEADER -d@'hostcreate.txt' $URL |jq .
 elif [ $Host -ge 1 ];then
    #echo $HOSTID   
    HostTemplate="{\"jsonrpc\":\"2.0\",\"method\":\"host.get\",\"params\":{\"output\":[\"hostid\"],\"selectParentTemplates\":[\"templateid\",\"name\"],\"hostids\":$HOSTID},\"id\":1,\"auth\":\"$KEY\"}"
    GetHostTemplate=`/usr/bin/curl -XPOST -s -H $HEADER -d$HostTemplate $URL |jq ".result[].parentTemplates[].name" |sed 's/["]//g'`
    #echo $SaltTemplate "and" $GetHostTemplate
    if [ "$SaltTemplate" == "$GetHostTemplate" ];then
      echo "Template not update"
    else
      sed -i "/auth/ s/:.*/\:  \"$KEY\",/" templateget.txt
      SaltTemplate=`salt-call --local grains.get zbtemplates |grep -v local |sed 's/-//g' |sed 's/^\s*//g' |while read -r line; do echo "\"$line\"";done |tr '\n' ','|sed 's/,$//'`
      sed -i "8s/^.*/$SaltTemplate/" templateget.txt
      TemplateID=`/usr/bin/curl -XPOST -s -H $HEADER -d@'templateget.txt' $URL |jq ".result[].templateid"`
      TemplateID2=`for i in $TemplateID ;do echo "{\"templateid\":$i}";done |tr '\n' ','|sed 's/,$//'`
      sed -i "/auth/ s/:.*/\:  \"$KEY\",/" hostupdate.txt
      sed -i "/\"hostid\"/ s/:.*/\:  $HOSTID,/" hostupdate.txt
      sed -i "7s/^.*/$TemplateID2/" hostupdate.txt
      /usr/bin/curl -XPOST -s -H $HEADER -d@'hostupdate.txt' $URL 
    fi
 else
    echo "Already Host"
 fi