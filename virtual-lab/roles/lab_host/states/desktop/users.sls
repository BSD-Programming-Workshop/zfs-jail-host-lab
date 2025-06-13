# Ensure roller is in additional groups for desktop functionality
roller_user_groups:
  user.present:
    - name: roller
    - groups:
      - operator
      - video
    - append: true
    - require:
      - user: roller_user
