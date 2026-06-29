# nixos-generate-config
{ config, lib, pkgs, modulesPath, ... }:
	{
	  imports = [
	    (modulesPath + "/installer/scan/not-detected.nix")
	  ];
	
	  boot.initrd.availableKernelModules = [
	    "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"
	  ];
	  boot.initrd.kernelModules  = [];
	  boot.kernelModules         = [ "kvm-intel" ];
	  boot.extraModulePackages   = [];
	
	  fileSystems."/" = {
	    device = "/dev/mapper/luks-42a7c992-69d0-4a4b-a2e5-23db684f9c3f";
	    fsType = "ext4";
	  };
	
	  boot.initrd.luks.devices."luks-42a7c992-69d0-4a4b-a2e5-23db684f9c3f".device =
	    "/dev/disk/by-uuid/42a7c992-69d0-4a4b-a2e5-23db684f9c3f";
	
	  fileSystems."/boot" = {
	    device  = "/dev/disk/by-uuid/E998-D55B";
	    fsType  = "vfat";
	    options = [ "fmask=0077" "dmask=0077" ];
	  };
	
	  swapDevices = [];
	  
	  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	  hardware.cpu.intel.updateMicrocode =
	    lib.mkDefault config.hardware.enableRedistributableFirmware;
	
	  services.fprintd.enable = true;  
	  services.fwupd.enable   = true;
	  hardware.bluetooth.enable = true;
	}
