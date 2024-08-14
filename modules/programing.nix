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
    ]))
    poetry # python library management
  ];
    
  fonts.packages = with pkgs; [
    fira-code-nerdfont
  ];
}
