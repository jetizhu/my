#!/bin/bash
exec 3<nginx_server
cat nginx_server |while read line <&3
do
  ip=`echo $line |awk '{print $1}'`
  pw=`echo $line |awk '{print $2}'`
  sshpass -p "$pw"  ssh -o "StrictHostKeyChecking no" root@$ip ls -l /etc/nginx/conf.d >/dev/null
  if [ $? == 0 ]
    then 
    mkdir conf/$ip 
    sshpass -p "$pw" scp $ip:/etc/nginx/conf.d/* conf/$ip/
    else
    echo "$ip no nginx"
  fi
done
