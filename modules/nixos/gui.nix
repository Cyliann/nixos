{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: 
{
  options = {
    gui.enable = lib.mkEnableOption "enables gui module";
  };

  config = lib.mkIf config.gui.enable {
    nixpkgs.config.permittedInsecurePackages = [
      "electron-38.8.4"
    ];

    environment.systemPackages = with pkgs; [
      kitty
      neovide
      swaynotificationcenter
      nwg-displays
      libnotify # dunst depends on this
      legcord
      pcmanfm
      gvfs # ftp support for pcmanfm
      wl-clipboard
      telegram-desktop
      zapzap # whatsapp
      anki-bin
      libreoffice
      zathura
      pavucontrol
      hyprshot
      mpd
      inputs.zen-browser.packages."${system}".default
      rmpc
      syncthing
      protonvpn-gui
      imv
      localsend
      zotero
      typst

      # Camera
      darktable
      gphoto2
      gphoto2fs

      # MPRIS
      playerctl
      mpdris2 # mpd
      (mpv.override {scripts = with mpvScripts; [mpris];})
      clematis # Discord rich presence
      kdePackages.kdeconnect-kde
      # inputs.muclic.packages.${system}.default

      # kdePackages.kdenlive
      gimp
      slack
      picard
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

    users.users.cylian = {
      extraGroups = [
        "nm-openvpn"
      ];
    };

    environment.sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = 1;

      # Fix Anki
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      ANKI_WAYLAND = 1;
    };

    networking.firewall = {
      enable = false;
      # Localsend support
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 ];
    };

    # Allows pipewire to use realtime scheduler for lower latency
    security.rtkit.enable = true;

    services = {
      gvfs.enable = true;

      # Enable CUPS to print documents.
      printing.enable = true;

      # Enable sound.
      pipewire = {
        enable = true;
        pulse.enable = true;
        extraConfig.pipewire-pulse."10-crackling-fix" = {
          "context.properties" = {
            "default.clock.allowed-rates" = [ 44100 48000 96000 ];
            "default.clock.quantum" = 256;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 1024;
          };

        };
      };

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;

      # Star hyprland automatically
      greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "${pkgs.hyprland}/bin/start-hyprland";
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
