#!/bin/bash



if [ -s /etc/puppet.yaml ];then 
	cat /etc/puppet.yaml
	exit 0
fi

LIP=$(hostname -I|head -n 1|awk '{print $1}')


if [ -s /opt/puppet/manifests/node/${LIP}.yaml ];then
	cat /opt/puppet/manifests/node/${LIP}.yaml
else
cat <<EOF
classes:
 vphotos::base:
EOF
fi
