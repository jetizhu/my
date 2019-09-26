from nginx import NGINX
import json
nginx = NGINX('/root/nginxcheck/conf/192.168.2.11/apps01.conf')
print(json.dumps((nginx.servers),sort_keys=True,indent=4))
