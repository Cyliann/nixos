{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";  
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      thickpad = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit system inputs;};
        modules = [
          ./hosts/thickpad/configuration.nix
          # inputs.home-manager.nixosModules.default
        ];
      };
      server = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit system inputs;};
        modules = [
          ./hosts/server/configuration.nix
        ];
      };
    };
  };
}
