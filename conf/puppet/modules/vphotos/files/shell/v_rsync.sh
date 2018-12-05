#!/bin/sh
case "$SSH_ORIGINAL_COMMAND" in
*\&*)
echo "Rejected"
;;
*\(*)
echo "Rejected"
;;
*\{*)
echo "Rejected"
;;
*\;*)
echo "Rejected"
;;
*\>*)
echo "Rejected"
;;
*\`*)
echo "Rejected"
;;
*\|*)
echo "Rejected"
;;
rsync\ --server*)
#echo "$SSH_CONNECTION" >>/var/log/v_rsync.log
$SSH_ORIGINAL_COMMAND
;;
*)
echo "Rejected"
;;
esac

