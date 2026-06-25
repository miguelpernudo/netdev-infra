{ config, lib, hostname, ... }:

{
  imports = [
    ../../modules/network/firewall-server.nix
    ../../modules/network/dns.nix
    ../../modules/network/trafficcontrol.nix
    ../../modules/network/ebpf.nix
  ];

  networking.hostName = hostname;

  # Choose one networking backend.
  networking.networkmanager.enable = lib.mkDefault false; 
  networking.useNetworkd = true;

  systemd.network.networks."10-ethernet" = {
    matchConfig.Name = "en*";
    networkConfig = {
      Address = "192.168.0.35/24";
      Gateway = "192.168.0.1";
      DNS = [ "9.9.9.9" "1.1.1.1" ];
    };
  };

  # Traffic control policies.
  services.traffic-control = {
    enable = true;
    script = ''
      tc qdisc add dev eth0 root handle 1: htb default 30
  
      tc class add dev eth0 parent 1: classid 1:1  htb rate 100mbit ceil 100mbit
      tc class add dev eth0 parent 1: classid 1:5  htb rate 20mbit  ceil 100mbit 
      tc class add dev eth0 parent 1: classid 1:10 htb rate 10mbit  ceil 30mbit
      tc class add dev eth0 parent 1: classid 1:30 htb rate 5mbit   ceil 20mbit
  
      tc filter add dev eth0 parent 1: protocol ip prio 1 u32 match ip sport 22 flowid 1:5
      tc filter add dev eth0 parent 1: protocol ip prio 1 u32 match ip sport 53 flowid 1:5
      tc filter add dev eth0 parent 1: protocol ip prio 1 u32 match ip sport 443 flowid 1:5
      tc filter add dev eth0 parent 1: protocol ip prio 1 u32 match ip sport 51820 flowid 1:5
      tc filter add dev eth0 parent 1: protocol ip prio 2 handle 10 fw flowid 1:10
    '';
  };
  
}
