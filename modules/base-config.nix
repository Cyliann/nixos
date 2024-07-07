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
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pl";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cylian = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
  networking.firewall.allowedTCPPorts = [ 22 ];
  
  system.stateVersion = "24.05"; # Did you read the comment?
}

