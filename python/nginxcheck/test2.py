#-*- coding: UTF-8 -*- 
from nginx import NGINX
import json
import re

for line in open("/root/nginxcheck/data/path"):
    #print (line),
    line2 = line,
    #print line2
    #print(re.sub(, ,line2))
    line=line.strip('\n')
    nginx = NGINX(line,)
    print(json.dumps((nginx.servers),sort_keys=True,indent=4))
    #print(nginx.servers)
