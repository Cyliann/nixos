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
      theme = {
        name = "FlatColor";
        package = pkgs.wpgtk;
      };
      iconTheme = {
        name = "Vimix-White-dark";
        package = pkgs.vimix-icon-theme;
      };
      cursorTheme = {
        name = "breezex-rosepinedawn";
        package = pkgs.rose-pine-cursor;
        size = 28;
      };
    };

    home.pointerCursor = {
      name = "breezex-rosepinedawn";
      package = pkgs.rose-pine-cursor;
      size = 28;
      gtk.enable = true;
    };
  };
}
