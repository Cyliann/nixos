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
        name = "Materia-dark";
        package = pkgs.materia-theme;
      };
    };
  };
}
