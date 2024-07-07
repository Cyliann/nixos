{  pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/base-config.nix
      ../../modules/gui.nix
      ../../modules/utils.nix
      ../../modules/programing.nix
      ../../modules/terminal.nix
      ../../modules/rice.nix
    ];
    
  networking.hostName = "thickpad";

  boot = {
    consoleLogLevel = 0;
    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail" ];

    plymouth =  {
      enable = true;
      themePackages = [(pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "lone" ]; }) ];
    };

    loader = {
      timeout = 0;
    };
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "cylian" = import ./home.nix;
    };

  };

}
