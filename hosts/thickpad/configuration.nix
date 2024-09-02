{  pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/modules.nix
    ];

  programming.enable = true;
  gui.enable = true;
  utils.enable = true;
  terminal.enable = true;
  rice.enable = true;
    
  networking.hostName = "thickpad";

  boot = {
    consoleLogLevel = 0;
    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail" ];

    plymouth =  rec {
      enable = true;
      theme = "lone";
      themePackages = [(pkgs.adi1090x-plymouth-themes.override { selected_themes = [ theme ]; }) ];
    };

    loader = {
      timeout = 0;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    bolt # thunderbolt management
  ];

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "cylian" = import ./home.nix;
    };
  };
}
