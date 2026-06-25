{ config, ... }:

{
	services.throttled.enable = false; 
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
   	settings = {
   		TLP_DEFAULT_MODE = "BAT";
  		TLP_PERSISTENT_DEFAULT = 0;

   		CPU_SCALING_GOVERNOR_ON_AC = "performance";
    	CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

   		CPU_MIN_PERF_ON_AC = 20;
    	CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 10;
      CPU_MAX_PERF_ON_BAT = 75;

      CPU_BOOST_ON_AC = 0; # If 1, it gets very hot.
      CPU_BOOST_ON_BAT = 0;

      # Without boost, setting it to 1 doesn't make change.
      CPU_HWP_DYN_BOOST_ON_AC = 0; 
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      START_CHARGE_THRESH_BAT0 = 30;
      STOP_CHARGE_THRESH_BAT0 = 80;

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 0;
      SOUND_POWER_SAVE_CONTROLLER = "N";

      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_AUDIO = 1;
      # USB_ALLOWLIST = "1234:5678";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      };
    };     
}
