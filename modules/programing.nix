{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rustup
    bun
    ntfs3g
    killall
  ];
    
  # Set up fonts
  fonts.packages = with pkgs; [
    fira-code-nerdfont
  ];
}
