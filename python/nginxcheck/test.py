#-*- coding: UTF-8 -*-

from nginx import NGINX
import os
import sys
import json
#nginx = NGINX('/root/nginxcheck/conf/192.168.2.11/apps01.conf')
#print(json.dumps((nginx.servers),sort_keys=True,indent=4))

def search(path, word):
    for filename in os.listdir(path):
        fp = os.path.join(path, filename)
        if os.path.isfile(fp) and word in filename:
            print ('/root/nginxcheck/'+fp)
	    #newfp = ('/root/nginxcheck/'+fp)
	    #nginx = NGINX(newfp)
	    #print(json.dumps((nginx.servers),sort_keys=True,indent=4))
	    #print(nginx.servers)
	    #print nginx
        elif os.path.isdir(fp):
            search(fp, word)
            #print(fp, word)

search(sys.argv[1], sys.argv[2])
