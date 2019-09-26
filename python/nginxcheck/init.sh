#!/bin/bash
cd  /root/nginxcheck
rm conf/*
rm data/*
bash scpconf.sh >/dev/null 2>&1
python path.py conf conf >data/path
python jsondata.py |jq '.[] | {server_name:.server_name,server_port:.port,backend:.backend[]}' |jq '. | {server_name:.server_name,server_port:.server_port,backend_ip:.backend.backend_ip,backend_path:.backend.backend_path}' |tr -d '\n' |tr '}' '\n' |sed 's/$/}/g' >data/json
#python sql.py 
