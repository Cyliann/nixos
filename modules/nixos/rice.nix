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
      sass
      fd
      brightnessctl
      wpgtk
      nwg-look
      adwaita-icon-theme
      matugen
      stow
      wlogout
      noctalia
    ];

    fonts.packages = with pkgs; [
      font-awesome
    ];
  };
}
