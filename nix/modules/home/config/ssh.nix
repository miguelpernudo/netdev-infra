{ config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      angler = {
        hostname     = "192.168.0.35";
        user         = "admin";
        identityFile = "~/.ssh/id_angler";
      };

      krill = {
        hostname     = "192.168.0.30";
        user         = "admin";
        identityFile = "~/.ssh/id_krill";
      };
      
      anglervpn = {
        hostname     = "10.100.0.1";
        user         = "admin";
        identityFile = "~/.ssh/id_angler";
      };
    };
  };
}
