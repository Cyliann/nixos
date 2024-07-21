{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
    wget
    gcc
    ripgrep
    nh
    zip
    unzip
    ntfs3g
    killall
    usbutils
    btop
    yt-dlp
  ];
}
