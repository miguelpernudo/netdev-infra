{ config, pkgs, ... }:

{
	imports = [
	  ./boot.nix
    ./hardware.nix
    ./networking.nix
    
    ### Core
    ../../modules/core

    ### System
    ../../modules/system/bash.nix     
    ../../modules/system/packages.nix

    ### Desktop
    ../../modules/desktop

    ### Users
    ../../modules/users/miguel.nix

    ### Security
    ../../modules/security/apparmor.nix
    #../../modules/security/audit.nix

    ### Hardware
    ../../modules/hardware/wellbeing.nix
    ../../modules/hardware/tlp.nix

    ## Services
    ../../modules/services/ssh.nix

    ### Others
    ../../modules/environment/sudoedit.nix
    ../../modules/insecure/pkgs.nix
  ];

  specialisation."rescue".configuration = {
     imports = [
       ../../modules/specialisations/rescue.nix
     ];
  };

  	# Change everything to your settings.
  mySettings = {
    locale   = "es_ES.UTF-8"; 
    timeZone = "Europe/Madrid";  
    keyMap   = "es";

    rescueDisableServices = []; 
    
    nix = {
      gcDates = "daily";
      deleteOlder = "7d";
      autoUpgrade = true;
      useNixld = true;
    };
  };      
  
  users.mutableUsers = true;
	nixpkgs.config.allowUnfree = true;


	sops.defaultSopsFile = ../../secrets/orca.yaml;
	sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # Change this at your own risk.
 	system.stateVersion = "25.11";
}
