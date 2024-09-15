{ pkgs, lib, config, ... }:
{
  options = {
    programming.enable = lib.mkEnableOption "enables programming module";
  };

  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
      gcc
      cargo
      bun
      ntfs3g
      killall
      (python311.withPackages (ps: with ps; [ # install python 3.12 and libraries
        requests
        numpy
        pandas
      ]))
      poetry # python library management
      jupyter
      luajitPackages.luarocks
    ];

    fonts.packages = with pkgs; [
      fira-code-nerdfont
    ];
  };
}
