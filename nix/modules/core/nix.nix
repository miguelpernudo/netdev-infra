{ config, pkgs, lib, ... }:

let 
  cfg = config.mySettings.nix;
in {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = config.mySettings.nix.gcDates;
    options = "--delete-older-than ${config.mySettings.nix.deleteOlder}";
  };

  system.autoUpgrade = {
    enable = config.mySettings.nix.autoUpgrade;
    allowReboot = false;
    operation = "boot";
    dates = "weekly";
  };

  programs.nix-ld = {
    enable = config.mySettings.nix.useNixld;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
    ];
  };
}	
