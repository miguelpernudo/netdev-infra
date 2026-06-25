{ config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      strata = {
        hostname     = "192.168.0.35";
        user         = "admin";
        identityFile = "~/.ssh/id_strata";
      };

      pathfinder = {
        hostname     = "192.168.0.30";
        user         = "admin";
        identityFile = "~/.ssh/id_pathfinder";
      };
      
      stratavpn = {
        hostname     = "10.100.0.1";
        user         = "admin";
        identityFile = "~/.ssh/id_strata";
      };
    };
  };
}
