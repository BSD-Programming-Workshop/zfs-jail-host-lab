/usr/local/etc/sudoers:
  file.managed:
    - source: salt://base/usr/local/etc/sudoers
    - mode: 444

roller_group:
  group.present:
    - name: roller

roller_user:
  user.present:
    - name: roller
    - fullname: Roller Angel
    - shell: /bin/tcsh
    - home: /home/roller
    - gid: roller
    - groups:
      - wheel
    - empty_password: True
    - createhome: True

roller_ssh_key:
  ssh_auth.manage:
    - user: roller
    - enc: ed25519
    - ssh_keys:
      - AAAAC3NzaC1lZDI1NTE5AAAAIJr6OPJeXUJzmDwIEgz7mbegmXQSBurn2xCIKlgDmrS3
