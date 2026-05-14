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

    # Bridge interface
    networking.defaultGateway = "10.54.54.1";
    networking.bridges.br0.interfaces = ["enp1s0"];
    networking.interfaces.br0 = {
      useDHCP = false;
      ipv4.addresses = [{
        "address" = "10.54.54.6";
        "prefixLength" = 24;
      }];
    };
    # Enable spice port
    networking.firewall.allowedTCPPorts = [
      5900
    ];
  };
}
