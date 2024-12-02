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
      rust-analyzer

      # Go
      go
      gopls

      # GLSL
      glsl_analyzer

      # JS
      bun
      typescript-language-server

      # Python
      (python311.withPackages (ps:
        with ps; [
          requests
          typing-extensions
          pytest
          yt-dlp
          ytmusicapi

          # for jupyter and DS
          jupyter
          ipython
          jupytext

          # for molten.nvim
          jupyter-client
          pynvim

          numpy
          pandas
          matplotlib
          scikit-learn
          seaborn
          statsmodels
        ]))
      poetry # python library management
      basedpyright
      ruff

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
      jetbrains-mono
    ];
  };
}
