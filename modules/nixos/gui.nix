{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    gui.enable = lib.mkEnableOption "enables gui module";
  };

  config = lib.mkIf config.gui.enable {
    environment.systemPackages = with pkgs; [
      kitty
      neovide
      dunst
      libnotify # dunst depends on this
      brave
      legcord
      pcmanfm
      gvfs # ftp support for pcmanfm
      wl-clipboard
      telegram-desktop
      anki-bin
      libreoffice
      zathura
      pavucontrol
      hyprshot
      whatsapp-for-linux
      mpd
      rmpc

      # MPRIS
      playerctl
      mpdris2 # mpd
      (mpv.override {scripts = with mpvScripts; [mpris];})
      clematis # Discord rich presence
      plasma5Packages.kdeconnect-kde
    ];

    nixpkgs.overlays = [
      (final: prev: {
        brave = prev.brave.override {
          commandLineArgs = "--enable-features=TouchpadOverscrollHistoryNavigation";
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

    fonts.packages = with pkgs; [
      noto-fonts-cjk-serif
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      wlr.enable = true;
    };

    environment.sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = 1;

      # Fix Anki
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      ANKI_WAYLAND = 1;
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
            command = "${pkgs.hyprland}/bin/Hyprland";
            user = "cylian";
          };
          default_session = initial_session;
        };
      };
    };

    hardware = {
      bluetooth.enable = true;
      graphics.enable = true;
      nvidia.modesetting.enable = true;
    };
  };
}
