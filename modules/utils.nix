{ pkgs, lib, config, ... }:
{
  options = {
    utils.enable = lib.mkEnableOption "enables utils module";
  };

  config = lib.mkIf config.utils.enable {
    environment.systemPackages = with pkgs; [
      neovim
      git
      lazygit
      wget
      gcc
      ripgrep
      nh
      zip
      unzip
      ntfs3g
      killall
      usbutils
      btop
      sshfs
    ];
  };
}
