# Ensure roller is in additional groups for desktop functionality
roller_user_desktop_groups:
  user.present:
    - name: roller
    - groups:
      - wheel
      - operator
      - video
    - require:
      - user: roller_user
