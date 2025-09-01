{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-06cb-009a-fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    # muclic = {
    #   url = "path:/home/cylian/git/muclic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      thickpad = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs;};
        modules = [
          ./hosts/thickpad/configuration.nix
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
        ];
      };
      server = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs;};
        modules = [
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
          ./hosts/server/configuration.nix
        ];
      };
    };
  };
}
