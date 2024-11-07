{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.rofi.enable = lib.mkEnableOption "enables rofi config";

  config = lib.mkIf config.modules.rofi.enable {
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
      file."/home/cylian/.config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/.config/rofi";
    };
  };
}
