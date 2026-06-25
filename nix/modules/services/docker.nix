{ config, pkgs, lib, ... }:

{
  options.services.docker = {
    enable = lib.mkEnableOption "Docker + Compose";
  };

  config = lib.mkIf config.services.docker.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      liveRestore = false;
      autoPrune.enable = true;
      autoPrune.dates = "weekly";
      daemon.settings = {
        log-driver = "journald";
        features.buildkit = true;
      };
    };

    virtualisation.docker-compose = {
      enable = true;
      enableOnBoot = false;
    };

  
    environment.systemPackages = with pkgs; [
      docker-compose
    ];

    users.users.admin.extraGroups = [ "docker" ];
  };
}
