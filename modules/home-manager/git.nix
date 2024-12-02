{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "enables git config";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      userName = "Cyliann";
      userEmail = "maksymilian@cych.eu";
    };
  };
}
