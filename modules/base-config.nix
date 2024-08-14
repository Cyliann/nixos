{ pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  networking.networkmanager.enable = true;
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.utf8";
      LC_IDENTIFICATION = "pl_PL.utf8";
      LC_MEASUREMENT = "pl_PL.utf8";
      LC_MONETARY = "pl_PL.utf8";
      LC_NAME = "pl_PL.utf8";
      LC_NUMERIC = "pl_PL.utf8";
      LC_PAPER = "pl_PL.utf8";
      LC_TELEPHONE = "pl_PL.utf8";
      LC_TIME = "en_US.utf8";
    };
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-chinese-addons
      ];
    };
  };
  console.keyMap = "pl";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cylian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    zsh.enable = true;
    mtr.enable = true; # ping and traceroute
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.sessionVariables = {
    # Find zsh config
    ZDOTDIR = "$HOME/.config/zsh";
  };
  
  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable NTP
    ntp.enable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22
    80
  ];
  
  system.stateVersion = "24.05"; # Did you read the comment?
}

