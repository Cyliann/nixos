{
lib,
config,
...
}: {
  options.modules.mime.enable = lib.mkEnableOption "enables mime config";

  config = lib.mkIf config.modules.mime.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = ["neovide.desktop"];
        "application/pdf" = ["zathura.desktop"];

        # Video player
        "video/mp4" = ["mpv.desktop"];
        "video/x-matroska" = ["mpv.desktop"];
        "video/webm" = ["mpv.desktop"];
        "video/x-msvideo" = ["mpv.desktop"];
        "video/x-ms-wmv" = ["mpv.desktop"];
        "video/ogg" = ["mpv.desktop"];
        "video/quicktime" = ["mpv.desktop"];
        "video/mpeg" = ["mpv.desktop"];

        # Image viewer
        "image/jpeg" = ["imv.desktop"];
        "image/png" = ["imv.desktop"];
        "image/gif" = ["imv.desktop"];
        "image/webp" = ["imv.desktop"];
        "image/tiff" = ["imv.desktop"];
        "image/bmp" = ["imv.desktop"];
        "image/x-tga" = ["imv.desktop"];
        "image/x-xbitmap" = ["imv.desktop"];
        "image/x-xpixmap" = ["imv.desktop"];
        "image/x-portable-pixmap" = ["imv.desktop"];
        "image/x-portable-bitmap" = ["imv.desktop"];
        "image/x-portable-graymap" = ["imv.desktop"];

        # Browser
        "text/html" = "ZenBrowser.desktop";
        "x-scheme-handler/http" = "ZenBrowser.desktop";
        "x-scheme-handler/https" = "ZenBrowser.desktop";
        "x-scheme-handler/about" = "ZenBrowser.desktop";
        "x-scheme-handler/unknown" = "ZenBrowser.desktop";
      };
    };
  };
}
