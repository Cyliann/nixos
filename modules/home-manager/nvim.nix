{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.nvim.enable = lib.mkEnableOption "enables nvim config";

  config = lib.mkIf config.modules.nvim.enable {
    programs.neovim = {
      enable = true;
      plugins = [
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      ];
    };

    home = {
      file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
    };
  };
}
