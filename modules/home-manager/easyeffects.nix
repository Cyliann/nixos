{
  lib,
  config,
  ...
}: {
  options.modules.easyeffects.enable = lib.mkEnableOption "enables easyeffects";

  config = lib.mkIf config.modules.easyeffects.enable {
    services.easyeffects = {
      enable = true;
      preset = "autoeq";
    };
  };
}
