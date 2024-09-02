{ pkgs, lib, config, ... }:
{
  options = {
    terminal.enable = lib.mkEnableOption "enables terminal module";
  };

  config = lib.mkIf config.terminal.enable {
    environment.systemPackages = with pkgs; [
      zoxide
      colorls
      fzf
      bat
      lf
      ranger
    ];
  };
}
