{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Cachix support
  nixConfig = {
    # override the default substituters
    substituters = [
      "https://cache.nixos.org"

      # nix community's cache server
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      # nix community's cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = {nixpkgs, nix-index-database, ...} @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      thickpad = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs;};
        modules = [
          ./hosts/thickpad/configuration.nix
          ./modules/nixos/modules.nix

          # add nix-index-database
          nix-index-database.nixosModules.default
          # also wrap and install comma
          { programs.nix-index-database.comma.enable = true; }
        ];
      };
      server = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs;};
        modules = [
          ./hosts/server/configuration.nix
          ./modules/nixos/modules.nix
        ];
      };
    };
  };
}
