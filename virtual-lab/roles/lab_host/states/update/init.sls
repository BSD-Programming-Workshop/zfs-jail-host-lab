update-cache-directory:
  file.directory:
    - name: /var/cache/freebsd-update
    - user: www
    - group: www

apache-setup:
  pkg.installed:
    - name: apache24
  file.managed:
    - names:
      - /usr/local/etc/apache24/Includes/update-cache.conf:
        - source: salt://update/usr/local/etc/apache24/Includes/update-cache.conf
      - /usr/local/etc/apache24/httpd.conf:
        - source: salt://update/usr/local/etc/apache24/httpd.conf
    - makedirs: True
  service.running:
    - name: apache24
    - restart: True
    - enable: True
    - watch:
      - file: /usr/local/etc/apache24/Includes/update-cache.conf
      - file: /usr/local/etc/apache24/httpd.conf
