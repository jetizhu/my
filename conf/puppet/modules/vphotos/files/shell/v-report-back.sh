#!/bin/bash
ELKSERVER="10.3.16.47"
elog(){
        hostname=$(cat /etc/hostname)
        echo "{\"hostname\":\"${hostname}\",\"action\":\"${1}\",\"status\":\"${3}\",\"comment\":\"${2}\",\"comment2\":\"${4}\"}"  >/dev/udp/${ELKSERVER}/5432
}

logger -t vbackup "${DIRVISH_CLIENT:-NULL} ${DIRVISH_STATUS:-NULL}"
elog "vbackup" "${DIRVISH_STATUS}" "${DIRVISH_CLIENT}" "NULL"
echo "ok"
exit 0
