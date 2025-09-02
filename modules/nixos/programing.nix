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

      # Go
      go
      gopls

      # GLSL
      glsl_analyzer

      # JS
      bun
      typescript-language-server

      # Python
      (python312.withPackages (ps:
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
          uv
        ]))
      poetry # python library management
      basedpyright
      ruff
      pipx

      # Lua LSP
      lua-language-server

      # Nix LSP dependencies
      nixd
      alejandra
      deadnix
      statix

      # Quality of life
      direnv
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      jetbrains-mono
    ];
  };
}
