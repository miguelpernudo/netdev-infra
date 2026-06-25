{ config, pkgs, ... }:

{
	# Nerd Fonts
  fonts.packages = with pkgs; [
	  nerd-fonts.jetbrains-mono
	  nerd-fonts.fira-code  
	  nerd-fonts.ubuntu-mono
  ];
}
