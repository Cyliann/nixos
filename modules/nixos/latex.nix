{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    latex.enable = lib.mkEnableOption "enables latex support";
  };

  config = lib.mkIf config.latex.enable {
    environment.systemPackages = with pkgs; [
      texliveBasic
      tectonic
    ];
  };
}
