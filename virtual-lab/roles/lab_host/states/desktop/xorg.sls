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

dbus:
  sysrc.managed:
    - value: "YES"
    - name: dbus_enable

# Xinitrc configuration
xinitrc:
  file.managed:
    - name: /home/roller/.xinitrc
    - contents: exec startxfce4
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