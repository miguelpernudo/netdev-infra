{ config, lib, ... }:

{
  imports = [
    ./desktop/ghostty.nix
    ./desktop/security.nix
    ./desktop/productivity.nix
    ./desktop/development.nix
    ./desktop/media.nix
    ./desktop/gaming.nix

    ./desktop/browsers/librewolf.nix
    ./desktop/browsers/chromium.nix
    
    ./config/micro-theme.nix
    ./config/helix.nix
    ./config/btop-theme.nix
    ./config/fastfetch.nix
    ./config/ssh.nix
    ./config/git.nix
    # ./config/nvim.nix
  ];
  
	home.username      = "miguel";
  home.homeDirectory = "/home/miguel";
  home.stateVersion  = "26.05";

  programs.home-manager.enable = true;
}
