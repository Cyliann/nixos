{
  lib,
  config,
  ...
}: {
  options.modules.nvim.enable = lib.mkEnableOption "enables nvim config";

  config = lib.mkIf config.modules.nvim.enable {
    programs.neovim = {
      enable = true;
      sideloadInitLua = true;
      withRuby = false;
      withPython3 = false;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      # extraConfig = lib.fileContents ../../dotfiles/neovim/init.lua;
    };

    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/neovim";
  };
}
