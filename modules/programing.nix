{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    cargo
    bun
    ntfs3g
    killall
    (python311.withPackages (ps: with ps; [ # install python 3.12 and libraries
      requests
    ]))
    poetry # python library management
    jupyter
  ];
    
  fonts.packages = with pkgs; [
    fira-code-nerdfont
  ];
}
