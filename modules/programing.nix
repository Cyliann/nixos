{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    cargo
    bun
    ntfs3g
    killall
    (python312.withPackages (ps: with ps; [ # install python 3.12 and libraries
      requests
      jupyterthemes
    ]))
    poetry # python library management
    jupyter
  ];
    
  fonts.packages = with pkgs; [
    fira-code-nerdfont
  ];
}
