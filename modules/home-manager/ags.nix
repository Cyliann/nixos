{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  options.modules.ags.enable = lib.mkEnableOption "enables ags config";

  config = lib.mkIf config.modules.ags.enable {
    # add the home manager module

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
