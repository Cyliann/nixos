{
  lib,
  config,
  ...
}: {
  options.modules.nvim.enable = lib.mkEnableOption "enables nvim config";

  config = lib.mkIf config.modules.nvim.enable {
    programs.neovim = {
      enable = true;
    };

    home = {
      file."${config.home.homeDirectory}/.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/.config/nvim";
    };
  };
}
