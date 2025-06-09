base_packages:
  pkg.latest:
    - order: 1
    - refresh: true
    - pkgs:
      - ca_root_nss
      - sudo
      - openssl
      - python311
      - py311-cryptography
      - py311-salt
      - pkg
      - vim

salt_minion:
  service.enabled:
    - name: salt_minion
    - sysrc:
        salt_minion_enable: "YES"

#removed since we aren't really re-configuring minion
#salt_minion:
#  pkg.latest:
#    - name: py311-salt
#  file.managed:
#    - template: jinja
#    - source: salt://base/usr/local/etc/salt/minion.j2
#    - name: /usr/local/etc/salt/minion
#  service.running:
#    - enable: true
#    - watch_any:
#      - pkg: py311-salt
#      - file: /usr/local/etc/salt/minion

localhost:
  host.present:
    - ip: 
      - 127.0.0.1
      - ::1
    - clean: true

update.lab.bsd.pw:
  host.present:
    - ip: 10.66.6.3
    - clean: true

/etc/freebsd-update.conf:
  file.managed:
    - source: salt://base/etc/freebsd-update.conf

# sendmail
sendmail:
  service.dead:
    - enable: False

sendmail_submit_enable:
  sysrc.managed:
    - value: "NO"
    - file: /etc/rc.conf.local

sendmail_outbound_enable:
  sysrc.managed:
    - value: "NO"
    - file: /etc/rc.conf.local

sendmail_msp_queue_enable:
  sysrc.managed:
    - value: "NO"
    - file: /etc/rc.conf.local


