{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/modules.nix
  ];

  terminal.enable = true;
  utils.enable = true;

  networking.hostName = "server";

  virtualisation.docker.enable = true;

  users.extraGroups.docker.members = ["cylian"];

  virtualisation.docker.storageDriver = "btrfs";

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "cylian" = import ./home.nix;
    };
  };

  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = false;
  };

  systemd.services."ddns-update" = {
    description = "Dynamic DNS Updater";
    wantedBy = ["multi-user.target"];
    path = [
      pkgs.curl
      pkgs.logger
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/cylian/cloudflare-ddns-updater/cloudflare.sh";
      User = "cylian";
      Group = "users";
    };
  };

  systemd.timers."ddns-update" = {
    description = "Dynamic DNS Updater";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1m";
      OnUnitActiveSec = "1m";
      Unit = "ddns-update.service";
    };
  };
}
