{
  lib,
  config,
  ...
}: {
  options.modules.wlsunset.enable = lib.mkEnableOption "enables automatic screen redshift";

  config = lib.mkIf config.modules.gtk.enable {
    services.wlsunset = {
      enable = true;
      latitude = 51;
      longitude = 5;
    };
  };
}
