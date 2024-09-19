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
          basedpyright
        ]))
      poetry # python library management
      jupyter
      luajitPackages.luarocks
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
