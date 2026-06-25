{ config, pkgs, ...  }:

{
  programs.gamemode.enable = true;
  
  # hardware.steam-hardware.enable = true;
  programs.steam = {
  	enable = true;
    gamescopeSession.enable = true;
  };
}
