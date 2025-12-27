{
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
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
    PermitRootLogin = "no";
  };
}
