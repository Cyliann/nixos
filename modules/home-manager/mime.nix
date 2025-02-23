{
  lib,
  config,
  ...
}: {
  options.modules.mime.enable = lib.mkEnableOption "enables mime config";

  config = lib.mkIf config.modules.mime.enable {
    xdg.mimeApps.defaultApplications = {
      "text/plain" = ["neovide.desktop"];
      "application/pdf" = ["zathura.desktop"];
      "video/png" = ["mpv.desktop"];
      "video/jpg" = ["mpv.desktop"];
      "video/*" = ["mpv.desktop"];
    };
  };
}
