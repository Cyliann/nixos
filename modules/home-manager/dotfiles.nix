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
      package = pkgs.rofi-wayland;
      plugins = [
        (pkgs.rofi-calc.override {
          rofi-unwrapped = pkgs.rofi-wayland-unwrapped;
        })
      ];
      configPath = "/tmp/hm-rofi.cfg";
    };

    home = {
      file.".config/*".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/.config/*";
    };
  };
}
