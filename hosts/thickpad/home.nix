{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cylian";
  home.homeDirectory = "/home/cylian";

  # add the home manager module
  # imports = [ inputs.ags.homeManagerModules.default ];

  # programs.ags = {
  #   enable = true;
  #
  #   # null or path, leave as null if you don't want hm to manage the config
  #   # configDir = ../ags;
  #
  #   # additional packages to add to gjs's runtime
  #   extraPackages = with pkgs; [
  #     gtksourceview
  #     webkitgtk
  #     accountsservice
  #   ];
  # };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # home.packages = [
  # ];

  home.sessionVariables = {
    EDITOR = "nvim";
    ZDOTDIR = "~/.config/zsh";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
