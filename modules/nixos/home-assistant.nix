{
  pkgs,
  lib,
  config,
  ...
  }: {
  options = {
    home-assistant.enable = lib.mkEnableOption "home-assistant";
  };

  config = lib.mkIf config.home-assistant.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      # For virt-install
      virt-manager

      # For lsusb
      usbutils
    ];

    # Access to libvirtd
    users.users.cylian = {
      extraGroups = ["libvirtd"];
    };
  };
}
