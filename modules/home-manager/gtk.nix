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
        name = "Vimix-White";
        package = pkgs.vimix-cursors;
        size = 28;
      };
    };
  };
}
