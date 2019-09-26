#!/bin/sh
read -p "select file:" file
read -p "Linux Command:" comm
if [ -f $file ]
then
exec 3<$file
cat $file |while read line<&3
do
  ip=`echo $line |awk '{print $1}'`
  pw=`echo $line |awk '{print $2}'`
  sshpass -p "$pw"  ssh -o "StrictHostKeyChecking no" root@$ip  "$comm"
done
else
  echo "no $file"
fi

