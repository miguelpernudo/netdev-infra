{ config, pkgs, lib, ... }:

# Reduces disk and RAM usage.
# As few packages as possible.

{
  environment.defaultPackages = lib.mkForce [];
  
  environment.systemPackages = with pkgs; [
      micro
      git
      curl
      
      age
      sops
      ssh-to-age
  ];
    
  documentation = {
    enable       = false;
    man.enable   = false;
    info.enable  = false;
    doc.enable   = false;
    nixos.enable = false;
  };

  services.journald.extraConfig = ''
    Storage=persistent
    SystemMaxUse=256M
    SystemKeepFree=128M
    MaxRetentionSec=1month
  '';

  zramSwap = {
    enable        = true;
    algorithm     = "zstd";
    memoryPercent = 50;
  };
}
