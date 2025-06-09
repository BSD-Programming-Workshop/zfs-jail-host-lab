# Network configuration
ifconfig_e0b_gateway:
  sysrc.managed:
    - value: "SYNCDHCP"

ifconfig_e1b_gateway:
  sysrc.managed:
    - value: "inet 10.66.6.1/24"

ifconfig_e2b_gateway:
  sysrc.managed:
    - value: "inet 192.168.66.1/24"

# Services
dhcpd:
  pkg.latest:
    - name: dhcpd
    - require:
      - sysrc: ifconfig_e1b_gateway
      - sysrc: ifconfig_e2b_gateway

dhcpd_service:
  sysrc.managed:
    - value: "YES"
    - name: dhcpd_enable
    - require:
      - pkg: dhcpd
      - file: /usr/local/etc/dhcpd.conf
      - file: /etc/pf.conf
    - watch:
      - file: /usr/local/etc/dhcpd.conf

pf:
  sysrc.managed:
    - value: "YES"
    - name: pf_enable

pflog:
  sysrc.managed:
    - value: "YES"
    - name: pflog_enable

gateway_enable:
  sysrc.managed:
    - value: "YES"
    - name: gateway_enable

/usr/local/etc/dhcpd.conf:
  file.managed:
    - source: salt://gateway/usr/local/etc/dhcpd.conf
    - user: root
    - group: wheel
    - mode: 644

/etc/pf.conf:
  file.managed:
    - source: salt://gateway/etc/pf.conf
    - user: root
    - group: wheel
    - mode: 600
    - watch:
      - cmd: reload_pf

reload_pf:
  cmd.wait:
    - name: pfctl -f /etc/pf.conf
    - watch:
      - file: /etc/pf.conf
      - service: pf