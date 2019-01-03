/etc/salt/minion:
  file.managed:
    - source: salt://salt/config/minion
    - user: root
    - group: root
    - mode: 644
    - template: jinja
/usr/local/sbin/saltlocal:
  file.managed:
    - source: salt://salt/sbin/saltlocal
    - user: root
    - group: root
    - mode: 777
    - template: jinja
