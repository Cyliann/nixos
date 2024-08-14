{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pywal
    wpgtk
    rofi-wayland
    hyprpaper
    hyprpanel
    swww
    sass
    fd
    brightnessctl
    wpgtk
    nwg-look
    adwaita-icon-theme
    matugen
    stow
  ];

  fonts.packages = with pkgs; [
    font-awesome
  ];
}
