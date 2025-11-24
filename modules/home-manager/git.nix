{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "enables git config";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Cyliann";
          email = "maksymilian@cych.eu";
        };
        extraConfig = {
          # Sign all commits using ssh key
          commit.gpgsign = true;
          gpg.format = "ssh";
          user.signingkey = "~/.ssh/git.pub";
        };
      };
    };
  };
}
