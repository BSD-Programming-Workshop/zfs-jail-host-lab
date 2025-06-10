# Desktop packages
xorg_packages:
  pkg.latest:
    - pkgs:
      - xorg
      - sudo
      - xfce
      - firefox
      - vim-x11

moused:
  sysrc.managed:
    - value: "YES"
    - name: moused_enable

dbus:
  sysrc.managed:
    - value: "YES"
    - name: dbus_enable

# Create machine-id for dbus
machine_id:
  file.managed:
    - name: /etc/machine-id
    - contents: "{{ salt['cmd.run']('dbus-uuidgen') }}"
    - mode: 0444
    - require:
      - pkg: xorg_packages

# X11 configuration
xinitrc:
  file.managed:
    - name: /home/roller/.xinitrc
    - contents: "exec startxfce4"
    - user: roller
    - group: wheel
    - mode: 0644
    - require:
      - pkg: xorg_packages

# Fstab configuration
fstab:
  file.managed:
    - name: /etc/fstab
    - contents: |
      fdescfs /dev/fd fdescfs rw 0 0
    - mode: 0644
    - require:
      - pkg: xorg_packages