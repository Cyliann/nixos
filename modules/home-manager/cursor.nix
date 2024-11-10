{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.cursor.enable = lib.mkEnableOption "enables cursor config";

  config = lib.mkIf config.modules.cursor.enable {
    gtk.cursorTheme = {
      name = "Vimix-White-dark";
      package = pkgs.vimix-cursors;
      size = 28;
    };
  };
}
