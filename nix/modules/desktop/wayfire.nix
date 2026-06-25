{ config, pkgs, pkgs-unstable, ... }:

{
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wayfire-plugins-extra
      wf-shell
    ];
  };

  ### Display Manager
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.wayfire}/bin/wayfire";
        user = "miguel";
      };
      default_session = {
        # Tuigreet on logout.
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd '${pkgs.wayfire}/bin/wayfire'";
        user = "greeter";
      };
    };
  };


  environment.systemPackages = with pkgs; [
    nordic
    wlr-randr

    thunar-archive-plugin
    thunar-media-tags-plugin
  ];

  ### XDG portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };
  };

  # GTK only
  programs.dconf.enable = true;

  # Thunar
  programs.thunar = {
    enable = true;
  };

  services.udisks2.enable = true;

  home-manager.users.miguel = {
    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = "40.4";
      longitude = "-3.7";
      temperature = {
        day = 6500;
        night = 3600;
      };
      settings = {
        general = {
          fade = 1;
        };
      };
    };

    home.packages = with pkgs; [
      papirus-icon-theme
      volantes-cursors

      # DMS and dependencies
      pkgs-unstable.quickshell
      pkgs-unstable.dms-shell

      pkgs-unstable.libnotify
      pkgs-unstable.brightnessctl
      matugen
    ];
  };
}
