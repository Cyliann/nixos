{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.dotfiles.enable = lib.mkEnableOption "enables dotfiles";

  config = lib.mkIf config.modules.dotfiles.enable {
    programs.rofi = {
      enable = true;
      plugins = [
        pkgs.rofi-calc
      ];
      configPath = "/tmp/hm-rofi.cfg";
    };

    home = {
      file.".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/.config/rofi";
      file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/.config/hypr";
    };
  };
}
