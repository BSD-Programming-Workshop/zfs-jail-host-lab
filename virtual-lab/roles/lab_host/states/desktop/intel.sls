# Intel Graphics Configuration

# Required packages
intel_packages:
  pkg.latest:
    - pkgs:
      - xf86-video-intel
      - drm-515-kmod

# Intel Xorg configuration
intel_xorg_conf:
  file.managed:
    - name: /usr/local/etc/X11/xorg.conf.d/20-modesetting.conf
    - source: salt://desktop/usr/local/etc/X11/xorg.conf.d/20-modesetting.conf
    - user: root
    - group: wheel
    - mode: 0644
    - require:
      - pkg: intel_packages
