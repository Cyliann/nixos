{ inputs, ... }:
{
  imports =
    [
    ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/base-config.nix
      ../../modules/terminal.nix
      ../../modules/utils.nix
    ];
    
  networking.hostName = "server";

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "cylian" = import ./home.nix;
    };

  };

}
