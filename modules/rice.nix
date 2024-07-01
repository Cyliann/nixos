{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pywal
    wpgtk
    rofi-wayland
    hyprpaper
    swww
    sass
    fd
    brightnessctl
    wpgtk
    nwg-look
    gnome.adwaita-icon-theme
    matugen
    stow
  ];
}
