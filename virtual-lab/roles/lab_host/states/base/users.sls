{{ username }}:
  user.present:
    - fullname: Roller Angel
    - shell: /bin/tcsh
    - home: /home/{{ username }}
    - uid: 1001
    - gid: wheel
    - empty_password: True
  ssh_auth.manage:
    - user: {{ username }}
    - enc: ed25519
    - ssh_keys:
      - AAAAC3NzaC1lZDI1NTE5AAAAIJr6OPJeXUJzmDwIEgz7mbegmXQSBurn2xCIKlgDmrS3

/usr/local/etc/sudoers:
  file.managed:
    - source: salt://base/usr/local/etc/sudoers
    - mode: 444
