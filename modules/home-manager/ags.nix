{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    ags.enable = lib.mkEnableOption "enables ags config";
  };

  config = lib.mkIf config.ags.enable {
    # add the home manager module
    imports = [inputs.ags.homeManagerModules.default];

    programs.ags = {
      enable = true;

      # null or path, leave as null if you don't want hm to manage the config
      # configDir = ../ags;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };
}
