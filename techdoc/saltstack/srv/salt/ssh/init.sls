huaxiaoping:
  user.present:
    - createhome: true
    - fullname: Hua Xiao Ping
    - shell: /bin/bash
  ssh_auth.present:
    - user: huaxiaoping
    - source: salt://ssh/keys/huaxiaoping.pub
    - config: '/%h/.ssh/authorized_keys'
hongqilin:
  user.present:
    - createhome: true
    - fullname: hongqilin
    - shell: /bin/bash
  ssh_auth.present:
    - user: hongqilin
    - source: salt://ssh/keys/hongqilin.pub
    - config: '/%h/.ssh/authorized_keys'
