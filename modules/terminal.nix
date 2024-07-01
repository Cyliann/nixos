{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zoxide
    colorls
    fzf
    bat
    lf
    ranger
  ];
}
