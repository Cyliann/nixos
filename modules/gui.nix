{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kitty
    neovide
    dunst
    libnotify # dunst depends on this
    brave
    armcord
    pcmanfm
    wl-clipboard
    telegram-desktop
    modrinth-app
    hypridle

    # MPRIS
    playerctl
    mpdris2 # mpd
    (mpv.override {scripts = with mpvScripts; [mpris];})
    clematis # Discord rich presence
  ];

  nixpkgs.overlays = [ 
    (final: prev: {
      brave = prev.brave.override {
        commandLineArgs =
        "--enable-features=TouchpadOverscrollHistoryNavigation";
      };
    })
  ];
  
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;
    waybar.enable = true;
    dconf.enable = true; # needed for wpgtk
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    wlr.enable = true;
  };

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = 1;

    # FIx Dolphin
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound.
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # Star hyprland automatically
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/hyprland";
          user = "cylian";
        };
        default_session = initial_session;
      };
    };
  };

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
}
