{ config, pkgs, ... }:

{  
  dconf.settings = {
    "org/kde/kdeglobals/General" = {
      ColorScheme = "OrchisBlack";
      # Font configuration can go here.
    };

    # Disable animations.
    # "org/kde/kdeclarative" = {
    #   AnimationDurationFactor = "0";
    # };
  };

  home.packages = with pkgs; [
    orchis-theme
    papirus-icon-theme
    bibata-cursors

    # qt5.full
  ] ++ (with pkgs.kdePackages; [
    # Add specific KDE apps as needed
  ]);

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 22;
  };

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "oxygen";
  };
}
