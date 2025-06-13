# Xorg Configuration

# Required Xorg packages
xorg_packages:
  pkg.latest:
    - pkgs:
      - xorg
      - vim-x11
      - firefox
      - xfce
      - git-lite

# Create machine-id for dbus
machine_id:
  file.managed:
    - name: /etc/machine-id
    - contents: "{{ salt['cmd.run']('dbus-uuidgen') }}"
    - mode: 0444
    - require:
      - pkg: xorg_packages

dbus:
  sysrc.managed:
    - value: "YES"
    - name: dbus_enable

# Xinitrc configuration
xinitrc:
  file.managed:
    - name: /home/roller/.xinitrc
    - contents: |
      exec startxfce4
    - user: roller
    - group: roller
    - mode: 0644
    - require:
      - pkg: xorg_packages

# Mouse configuration
moused:
  sysrc.managed:
    - value: "YES"
    - name: moused_enable