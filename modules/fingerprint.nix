{ ... }:

{
# Make fingerprint work
  services.open-fprintd.enable = true;
  services.python-validity.enable = true;

  security.pam.services.login.fprintAuth = true;

# For some reason NixOS keeps overwriting this file
  security.pam.services.hyprlock.text = ''
# PAM configuration file for hyprlock
# the 'login' configuration file (see /etc/pam.d/login)

    auth        include     login
    '';

# Needs to restart python3-validity after suspend
  systemd.services.restartFingerprint = {
    unitConfig = {
      After = [
        "suspend.target"
          "hibernate.target"
          "hybrid-sleep.target"
          "suspend-then-hibernate.target"
      ];
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "systemctl restart python3-validity";
    };
    wantedBy = [
      "suspend.target"
        "hibernate.target"
        "hybrid-sleep.target"
        "suspend-then-hibernate.target"
    ];
  };
}
