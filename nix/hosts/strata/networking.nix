{ config, lib, hostname, ... }:

{
  imports = [
    ./firewall.nix
    
    ../../modules/network/dns.nix
    #../../modules/network/trafficcontrol.nix
    #../../modules/network/ebpf.nix
  ];

  networking.hostName = hostname;

  # Choose one networking backend.
  networking.networkmanager.enable = lib.mkDefault false; 
  networking.useNetworkd = true;

  # systemd.network.networks."10-ethernet" = {
  #   matchConfig.Name = "en*";
  #   networkConfig = {
  #     Address = "192.168.0.35/24";
  #     Gateway = "192.168.0.1";
  #     DNS = [ "9.9.9.9" "1.1.1.1" ];
  #   };
  # };
}
