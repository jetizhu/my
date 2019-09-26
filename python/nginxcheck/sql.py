#-*- coding: UTF-8 -*-
import json

data = []
with open('/root/nginxcheck/data/json') as f:
    for line in f:
        data.append(json.loads(line))

#print json.dumps(data, ensure_ascii=False)

str = "\r\n"
for item in data:
#    #print json.dumps(item)
    str = str + "insert into main_data(server_name,server_port,backend_ip,backend_path) values "
    str = str + "('%s','%s','%s','%s');\r\n" % (item['server_name'],item['server_port'],item['backend_ip'],item['backend_path'])

import codecs
file_object = codecs.open('data/sql', 'w' ,"utf-8")
file_object.write(str)
file_object.close()
print "success"
