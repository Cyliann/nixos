{
lib,
config,
...
}: {
  options.modules.kanshi.enable = lib.mkEnableOption "enables automatic display configuration";

  config = lib.mkIf config.modules.kanshi.enable {
    services.kanshi = {
      enable = true;
      systemdTarget = "hyprland-session.target";

      settings = [
        {
          profile.name = "undocked";
          profile.outputs = [
            {
              criteria = "eDP-1";
              scale = 1.2;
              status = "enable";
            }
          ];
        }
        {

          profile.name = "docked";
          profile.outputs = [
            {
              criteria = "HDMI-A-1";
              status = "enable";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        }
      ];
    };
  };
}
