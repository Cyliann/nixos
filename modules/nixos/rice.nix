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
      rofi-wayland
      hyprpaper
      hyprpanel
      hyprcursor
      swww
      sass
      fd
      brightnessctl
      wpgtk
      nwg-look
      adwaita-icon-theme
      matugen
      stow
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    ];

    fonts.packages = with pkgs; [
      font-awesome
    ];
  };
}
