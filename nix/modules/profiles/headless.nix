{ config, pkgs, lib, ... }:

# Strips everything GUI, desktop, and graphical from the system.
{
  ### Display
  services.xserver.enable = lib.mkForce false;
  services.displayManager.enable = lib.mkForce false;

  # Disable GPU firmware loading where possible.
  hardware.graphics.enable = false;

  ### Desktop
  services.printing.enable = false;
  services.avahi.enable = false;

  # Disk automount daemon.
  services.udisks2.enable = false;

  hardware.bluetooth.enable = false;
  services.blueman.enable   = false;

  services.power-profiles-daemon.enable = false;

  ### Geolocation
  services.geoclue2.enable = lib.mkDefault false;

  ### Portal
  xdg.portal.enable = lib.mkDefault false;

  ### Audio 
  services.pipewire.enable   = false;
  services.pulseaudio.enable = false;

  ### Fonts
  # No fonts needed.
  fonts.fontconfig.enable = false;
  fonts.packages          = lib.mkForce [];
}
