{...}: {
  imports = [
    ../../modules/home-manager/modules.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cylian";
  home.homeDirectory = "/home/cylian";

  modules = {
    gtk.enable = true;
    git.enable = true;
    nvim.enable = true;
    rofi.enable = true;
    # ags.enable = true;
    easyeffects.enable = true;
    mime.enable = true;
    zen-browser.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    ZDOTDIR = "~/.config/zsh";
  };

  programs.home-manager.enable = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
