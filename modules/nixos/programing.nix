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
      # C
      gcc

      # Rust
      cargo

      # Go
      go
      gopls

      # GLSL
      glsl_analyzer

      # JS
      bun

      # Python
      (python311.withPackages (ps:
        with ps; [
          requests
          numpy
          pandas
          matplotlib
          typing-extensions
          pytest
        ]))
      poetry # python library management
      basedpyright

      # Lua LSP
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
