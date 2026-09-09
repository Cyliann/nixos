{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.gtk.enable = lib.mkEnableOption "enables gtk config";

  config = lib.mkIf config.modules.gtk.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Vimix-white-dark";
        package = pkgs.vimix-icon-theme;
      };
      cursorTheme = {
        name = "BreezeX-RosePineDawn-Linux";
        package = pkgs.rose-pine-cursor;
        size = 28;
      };
    };

    home.pointerCursor = {
      enable = true;
      name = "BreezeX-RosePineDawn-Linux";
      package = pkgs.rose-pine-cursor;
      size = 28;
      gtk.enable = true;
    };
  };
}
