{ config, pkgs, ... }:

{
	users.users.miguel = {
	  isNormalUser = true;
	  description = "Miguel";
	  extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
	};
}
