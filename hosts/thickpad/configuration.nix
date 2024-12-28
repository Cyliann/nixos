{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nixos/modules.nix
  ];

  battery.enable = true;
  programming.enable = true;
  gui.enable = true;
  utils.enable = true;
  terminal.enable = true;
  rice.enable = true;
  latex.enable = true;

  networking.hostName = "thickpad";

  boot = {
    consoleLogLevel = 0;
    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    kernelParams = ["quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail"];
    extraModulePackages = with config.boot.kernelPackages; [perf];
    plymouth = rec {
      enable = true;
      theme = "lone";
      themePackages = [(pkgs.adi1090x-plymouth-themes.override {selected_themes = [theme];})];
    };

    loader = {
      timeout = 0;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    bolt # thunderbolt management
    android-tools
  ];

  # Firewall rule for KDE connect
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedTCPPorts = [8096];
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "hm.bak";
    users = {
      "cylian" = import ./home.nix;
    };
  };
}
