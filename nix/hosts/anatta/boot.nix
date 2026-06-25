{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot = {
  	    enable = true;
  	    configurationLimit = 10;
      };
    
  	  efi.canTouchEfiVariables = true;
    };
      
    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;
  };
}
