{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    rice.enable = lib.mkEnableOption "enables rice module";
  };

  config = lib.mkIf config.rice.enable {
    environment.systemPackages = with pkgs; [
      pywal
      wpgtk
      hyprpaper
      inputs.hyprpanel.packages.${system}.default
      swww
      sass
      fd
      brightnessctl
      wpgtk
      nwg-look
      adwaita-icon-theme
      matugen
      stow
      wlogout
      inputs.ignis.packages.${system}.ignis
    ];

    fonts.packages = with pkgs; [
      font-awesome
    ];
  };
}
