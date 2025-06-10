# VirtualBox guest additions
virtualbox_packages:
  pkg.latest:
    - pkgs:
      - virtualbox-ose-additions

# VirtualBox guest additions services
vboxguest:
  sysrc.managed:
    - value: "YES"
    - name: vboxguest_enable

vboxservice:
  sysrc.managed:
    - value: "YES"
    - name: vboxservice_enable
