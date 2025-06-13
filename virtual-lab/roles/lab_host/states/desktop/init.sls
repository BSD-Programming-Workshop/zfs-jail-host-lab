# Fstab configuration
fstab:
  file.managed:
    - name: /etc/fstab
    - contents: |
      fdescfs /dev/fd fdescfs rw 0 0
    - mode: 0644

