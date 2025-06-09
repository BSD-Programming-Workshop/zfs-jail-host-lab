# Network configuration
ifconfig_e0b_gateway:
  service.enabled:
    - name: ifconfig_e0b_gateway
    - sysrc:
        ifconfig_e0b_gateway: "SYNCDHCP"

ifconfig_e1b_gateway:
  service.enabled:
    - name: ifconfig_e1b_gateway
    - sysrc:
        ifconfig_e1b_gateway: "inet 10.66.6.1/24"

ifconfig_e2b_gateway:
  service.enabled:
    - name: ifconfig_e2b_gateway
    - sysrc:
        ifconfig_e2b_gateway: "inet 192.168.66.1/24"

# Services
salt_minion:
  service.enabled:
    - name: salt_minion
    - sysrc:
        salt_minion_enable: "YES"

dhcpd:
  pkg.installed:
    - name: dhcpd
    - require:
      - service: ifconfig_e1b_gateway
      - service: ifconfig_e2b_gateway

dhcpd_service:
  service.enabled:
    - name: dhcpd
    - sysrc:
        dhcpd_enable: "YES"
    - require:
      - pkg: dhcpd
      - file: /usr/local/etc/dhcpd.conf
    - watch:
      - file: /usr/local/etc/dhcpd.conf

pf:
  service.enabled:
    - name: pf
    - sysrc:
        pf_enable: "YES"
        pflog_enable: "YES"

gateway_enable:
  service.enabled:
    - name: gateway_enable
    - sysrc:
        gateway_enable: "YES"

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
    - watch_in:
      - cmd: reload_pf

reload_pf:
  cmd.wait:
    - name: pfctl -f /etc/pf.conf
    - watch:
      - file: /etc/pf.conf

# Ensure services are running
ensure_services_running:
  service.running:
    - names:
      - salt_minion
      - dhcpd
      - pf
    - enable: true
    - watch:
      - service: salt_minion
      - service: dhcpd
      - service: pf