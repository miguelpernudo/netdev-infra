{ config, pkgs, ... }:

{
  ### SERVICES
	services.journald.extraConfig = ''
  	SystemMaxUse=500M
	'';

	services.earlyoom.enable = true;
	
  ### BOOT
  #boot.kernel.systctl."kernel.sched_autogroup_enabled" = 1;

  boot.kernel.sysctl."vm.dirty_writeback_centisecs" = 3000;  
}
