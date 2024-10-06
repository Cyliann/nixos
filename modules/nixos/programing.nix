{
  pkgs,
  lib,
  config,
  ...
}: {
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
      (python311.withPackages (ps:
        with ps; [
          requests
          numpy
          pandas
          matplotlib
        ]))
      poetry # python library management
      basedpyright
      lua-language-server
      # Nix LSP dependencies
      nixd
      alejandra
      deadnix
      statix
    ];

    fonts.packages = with pkgs; [
      fira-code-nerdfont
    ];
  };
}
