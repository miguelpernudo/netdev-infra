{ config, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    #theme = "";
  };

  services.desktopManager.plasma6.enable = true; 

  # services.baloo.enable = false; # Desktop search indexing.

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    plasmatube
    elisa
    #kdeconnect
    discover
  ];

  #environment.systemPackages = with pkgs.kdePackages; [
  #  polonium
  #];

  home-manager.users.miguel = {
    imports = [
      ../home/desktop/kde.nix
    ];
  };
}
