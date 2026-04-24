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
      (python3.withPackages (ps:
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
      basedpyright
      ruff
      pipx
      ty

      # Lua LSP
      lua-language-server

      # Nix LSP dependencies
      nixd
      alejandra
      deadnix
      statix

      # Typst
      tinymist

      # Arduino
      arduino-cli
      arduino-language-server
      clangStdenv

      # Quality of life
      gh
      just

      #Julia
      julia-bin
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      jetbrains-mono
    ];
  };
}
