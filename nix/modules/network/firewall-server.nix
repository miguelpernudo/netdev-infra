{ config, pkgs, ... }:

# https://wiki.nftables.org

{
  networking.firewall.enable = false;
  networking.nftables = {
    enable = true;
    ruleset = ''
      flush ruleset
      
      define LAN = 192.168.0.0/16
      define WG = 10.100.0.0/24
      
      table inet filter {

        chain input {
          type filter hook input priority filter; policy drop;

          ct state established,related accept;
          ct state invalid drop;
          iifname "lo" accept;

          # ICMP
          ip  protocol icmp limit rate 10/second burst 20 packets accept;
          ip6 nexthdr icmpv6 icmpv6 type {
            nd-neighbor-solicit, nd-neighbor-advert,
            nd-router-advert,   nd-router-solicit
          } accept;
          
          ip6 nexthdr icmpv6 limit rate 10/second burst 20 packets accept;

          # SSH (LAN and VPN only)
          tcp dport 22 meta nfproto ipv4 ip saddr { $LAN, $WG } ct state new meter ssh_brute { ip saddr timeout 2m limit rate 3/minute burst 5 packets } accept;

          # WireGuard.
          udp dport 51820 accept;

          # DNS 
          # tcp dport 53 ip saddr $LAN accept;
          # udp dport 53 ip saddr $LAN accept;

          # Services, by VPN.
          iifname "wg0" tcp dport {
          #  80, 443,   # Traefik
          #  3000,      # AdGuard panel
            3001,      # Grafana
            9090,      # Prometheus
          #  3100       # Loki
          } accept;

          # Services, by LAN.
          ip saddr $LAN tcp dport {
            3001, 
            9090, 
            3100
          } accept;

          counter log prefix "NFT-DROP: " limit rate 5/minute drop;
        }

        chain forward {
          type filter hook forward priority filter;
          policy drop;
          ct state established,related accept;
          ct state invalid drop;

          # WireGuard
          iifname "wg0" oifname "enp2s0" accept;
        }

        chain output {
          type filter hook output priority filter;
          policy accept;
        }
      }

      # Mark Docker bridge traffic for QoS class 1:10.
      table ip mangle {
        chain forward {
          type filter hook forward priority mangle;
          iifname "docker0" meta mark set 10;
        }
      }

      # Masquerade for WireGuard.
      table ip nat {
        chain postrouting {
          type nat hook postrouting priority srcnat;
          # oifname "enp2s0" masquerade;
          ip saddr $WG oifname "enp2s0" masquerade;
        }
      }
    '';
  };
}
