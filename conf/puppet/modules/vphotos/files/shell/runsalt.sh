#!/bin/bash
[  -f /opt/salt/top.sls ]||exit 0
mv /tmp/salt.log /tmp/salt.log.old
salt-call --local state.highstate 2>/dev/null > /tmp/salt.log

cat /tmp/salt.log
