#!/bin/bash
[ $# -eq 0 ]&&exit 0
pkgs=$(dpkg -l|awk '{print $2}')
for i in `seq $#`;do
	pkg=$(eval echo \$$i )
	echo "$pkgs" | grep -q $pkg
	if [ $? -ne 0 ];then
		echo "FAIL"
		exit 0
	fi
	
	
done
echo OK
