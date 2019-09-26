#-*- coding: UTF-8 -*-
#coding=utf-8
import MySQLdb
conn = MySQLdb.connect(
                host='10.9.36.141',
                port=3306,
                user='user25116',
                passwd='Django_Python@123',
                db='ngxconf',
                #charset='utf8',
            )
cur = conn.cursor()
f = open('/root/nginxcheck/data/sql')
while True:
    line = f.readline()
    if line:
        line = line.strip('\n')
        #print line
	cur.execute(line)
    else:
        break
f.close()
cur.close()
conn.commit()
conn.close()
