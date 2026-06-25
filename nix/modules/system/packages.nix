{ config, pkgs, ...  }:

{     
	environment.systemPackages = with pkgs; [
   	wget
   	curl
   	unzip
   	file
   	ncdu
 		tldr
  	jq
  	yq
   	tree
		btop
		micro
		git
		bat
    usbutils

	  age
	  sops
	  ssh-to-age
	];
}
