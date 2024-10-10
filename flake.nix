{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    nixos-06cb-009a-fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        inputs.hyprpanel.overlay
      ];
    };
  in {
    nixosConfigurations = {
      thickpad = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs pkgs;};
        modules = [
          ./hosts/thickpad/configuration.nix
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
        ];
      };
      server = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs pkgs;};
        modules = [
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
          ./hosts/server/configuration.nix
        ];
      };
    };
  };
}
