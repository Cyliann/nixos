{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    ripgrep
    nh
    zip
    unzip
    ntfs3g
    killall
  ];
}
