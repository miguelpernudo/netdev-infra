{ config, pkgs, ... }:

# Scanners, rootkit detectors, and automated checks.
{
  environment.systemPackages = with pkgs; [

    # CVE scanner specific for NixOS.
    vulnix

    # Uncomment if you added suricata
    # suricata-update

  ];
  
  ## vulnix weekly timer
  ## Check with: cat /var/log/vulnix.log
  systemd.services.vulnix-scan = {
    description = "Vulnix scan";
    serviceConfig = {
    Type = "oneshot";
    ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.vulnix}/bin/vulnix --system > /var/log/vulnix.log 2>&1'";
    User = "root";
    };
  };
  
  systemd.timers.vulnix-scan = {
    description = "Vulnix-scan timer";
    wantedBy = [ "timers.target" ];
    timerConfig = {
    OnCalendar = "monthly"; # or weekly if you prefer it.
    Persistent = true;
    };
  };
}
