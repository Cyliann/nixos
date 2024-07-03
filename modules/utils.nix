{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    gcc
    ripgrep
    nh
    zip
    unzip
    ntfs3g
    killall
  ];
}
