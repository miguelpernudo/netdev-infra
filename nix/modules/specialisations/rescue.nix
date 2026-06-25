{ config, pkgs, lib, hostname,... }:

# The rescue specialisation:
# Environment to recover a broken system.
#
###  WARNING!!!
# This lowers security deliberately to allow emergency access, so
# please, do not leave the system booted in rescue mode longer than needed.

{
  specialisation.rescue.configuration = {
  
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
    systemd.enableEmergencyMode = true;

    # Easy root access.
    users.users.root.initialHashedPassword = "$6$mxxwaIV64NfHOlUX$FAw3x7ZMswZ/shfymhv/0wZoftKjWKKdPME0VOOvR.9Lu6F1f.zYgyOnh0Lm24dumtHK8uUV4SRF5eQuXOkeU/"; # FIXME

    # Identify easily
    networking.hostName = lib.mkForce "${hostname}-rescue";

    # Replace nftables with the nixos firewall.
    
    # IMPORTANT: This configuration  would not remove 
    # the current nftables rules, so after booting in
    # this mode, do this if you want them to have no effect:
    # sudo nft flush ruleset
    # sudo systemctl restart sshd   # If you want to use ssh.
    
    networking.nftables.enable          = lib.mkForce false;
    networking.firewall.enable          = lib.mkForce true;

    # SSH always open.
    networking.firewall.allowedTCPPorts = lib.mkForce [ 22 ];
    services.openssh.enable             = lib.mkForce true;

    # Headless.
    services.xserver.enable              = lib.mkForce false;
    services.displayManager.gdm.enable   = lib.mkForce false;
    services.desktopManager.gnome.enable = lib.mkForce false;
    services.flatpak.enable              = lib.mkForce false;
    services.pipewire.enable             = lib.mkForce false;
    services.pulseaudio.enable           = lib.mkForce false;

    # These options make the remote rebuild easier.
    nix.settings.trusted-users = [ "root" "admin" "miguel" "@wheel" ]; # Everyone.

    nix.gc.automatic            = lib.mkForce false;
    system.autoUpgrade.enable   = lib.mkForce false;

    # Disabling signature verification is dangerous as it 
    # allows the installation of unverified binaries.
    # This is only useful if you're going to use another 
    # PC to temporarily act as a binary cache for the current host.
    nix.settings.require-sigs = false;

    # Stop services declared in settings.nix
    systemd.services = lib.genAttrs (config.mySettings.rescueDisableServices or [ ])
      (_: { wantedBy = lib.mkForce []; });

    environment.systemPackages = with pkgs; [
      # Disk
      testdisk 
      ddrescue 
      parted 
      gptfdisk
      e2fsprogs 
      dosfstools 
      cryptsetup
      lvm2 
      btrfs-progs 
      ntfs3g 
      keyutils

      # Recovery
      rsync 
      rclone

      # Network
      nmap 
      tcpdump 
      netcat-openbsd 
      wget

      # Inspection
      strace 
      ltrace 
      lsof 
      file 
      binutils

      # Boot
      efibootmgr

      # Secrets
      age 
      sops
    ];
  };
}

