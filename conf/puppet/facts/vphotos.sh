#!/bin/bash
#
# output format:
# 
#    key1=val1  
#    key2=val2
# 


#   add facts
#  cpu load
#  listen port
#  vphotos package
#  vphotos nginx site
#  puppet config
#  vphotos tomcat site

 

export LANG=C
export PATH="/usr/bin:/usr/sbin:/bin:/sbin"

echo "index=puppetstatus"
w |grep -o "load.*"|awk '{print "v_load1="$3}'|sed 's/,//'
df /|awk '$1 ~/dev/ {print "v_root_free="$4}'
vmstat  |tail -n 1|awk '{print "run_p="$1"\nunintsleep_p="$2"\nswpd="$3"\nfree="$4"\nbuff="$5"\ncache="$6"\niobi="$9"\niobo="$10"\nsysin="$11"\nsyscs="$12"\ncpuus="$13"\ncpusy="$14"\ncpuid="$15"\ncpuwa="$16"\ncpust="$17}'|sed 's/^/v_/'


# 常用tcp 端口
netstat -nat|grep -i listen |grep -v tcp6|awk '{print $4}'|awk -F":" '{print $2}'|grep -e 80 -e 8080 -e 22 -e 10050 -e 3306 -e 873 -e 27017|tr '\n' ','|sed -e 's/,$/\n/' -e 's/^/v_tcp_normal=/'
# 不常用tcp 端口
netstat -natp|grep -i listen |grep -v tcp6|awk '{print $4","$7}'|awk -F":" '{print $2}'|grep -v -e 80 -e 8080 -e 22 -e 10050 -e 3306 -e 873 -e 27017|tr '\n' ','|sed -e 's/,$/\n/' -e 's/^/v_tcp_other=/'

netstat -naup|grep -v udp6|awk '$5 ~/0.0.0.0:*/ {print $4","$6}'|sed 's/.*://'|sort|uniq|tr '\n' ','|sed -e 's/^/v_udp_listen=/' -e 's/,$/\n/'

dpkg -l|grep vphoto|awk '{print $2":"$3}'|tr '\n' ','|sed -e 's/^/v_packages=/' -e 's/,$/\n/'
