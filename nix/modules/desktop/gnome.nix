{ config, pkgs, ... }:

{
	services.displayManager.gdm.enable = true;
	services.desktopManager.gnome.enable = true;
	hardware.graphics.enable = true;


	# services.gnome.localsearch.enable = false; 
	# services.gnome.tinysparql.enable = false; 
	services.gnome.gnome-remote-desktop.enable = false;
	
  #services.gnome.core-apps.enable = false;

xdg.portal = {
    enable = true;
    
    config = {
      gnome = {
        default = [ "gnome" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
      };
      common = {
        default = [ "gnome" "gtk" ];
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  
   programs.dconf.enable = true;
   
   environment.gnome.excludePackages = with pkgs; [
  	  gnome-music
  		simple-scan
  		gnome-connections
  		gnome-font-viewer
 	  	gnome-characters
 	  	gnome-logs
 	    gnome-software
	    yelp
 	    orca
      totem
 	    gnome-weather
 	    gnome-maps
      gnome-tour
      gnome-contacts
      geary
      epiphany
      tali
      atomix
      quadrapassel
   	  gnome-terminal
  	  gnome-console
  	  decibels
  	  showtime
    ];  

    home-manager.users.miguel = {
      imports = [
        ../home/desktop/gnome.nix
      ];
    };
}
