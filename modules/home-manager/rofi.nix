{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    modules.rofi.enable = lib.mkEnableOption "enables rofi config";
  };

  config = lib.mkIf config.modules.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = [
        (pkgs.rofi-calc.override {
          rofi-unwrapped = pkgs.rofi-wayland-unwrapped;
        })
      ];
    };

    home = {
      file."${config.home.homeDirectory}.config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/.config/rofi";
    };
  };
}
