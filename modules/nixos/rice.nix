{
  pkgs,
  lib,
  config,
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
    ];

    fonts.packages = with pkgs; [
      font-awesome
    ];
  };
}
