{ config, lib, hostname, ... }:

{
  imports = [
    ./firewall.nix
    
    ../../modules/network/dns.nix
    # ../../modules/network/cloudflare-warp.nix
  ];

  networking.hostName = hostname;

  # Choose one networking backend.
  networking.networkmanager.enable = true; 
  networking.useNetworkd = lib.mkDefault false;

  ### Wireguard (network manager).
  #networking.networkmanager.ensureProfiles = {
  #  environmentFiles = [ config.sops.templates."wg-env".path ];
  #  profiles = {
  #    angler = {
  #        connection = {
  #          id = "Angler";
  #          type = "wireguard";
  #          interface-name = "angler";
  #          autoconnect = false;
  #        };
  #        wireguard = {
  #          private-key = "$WG_PRIVATE_KEY"; 
  #        };
  #        
  #        "wireguard-peer.ttXAvtimbEJxuEa92SJcNHIOt+KEUG92F0SaXMITHX8=" = {
  #          endpoint = "46.136.62.166:51820";
  #          allowed-ips = "0.0.0.0/0;";
  #          persistent-keepalive = 25;
  #        };
  #        ipv4 = {
  #          method   = "manual";
  #          address1 = "10.100.0.2/24";
  #        };
  #        ipv6 = {
  #          method = "disabled";
  #        };
  #      };
  #    };
  #  };
    
  ### Wireguard (interface).  
  #networking.wireguard.interfaces = {
  #  angler = {
  #    ips            = [ "10.100.0.2/24" ];
  #    privateKeyFile = config.sops.secrets.wg_private_key.path;
  #
  #    peers = [{
  #      publicKey           = "5D8OmhtA1WWugnN7RT+cXncjYLgk/MZVAh6hPJAXyR8=";
  #      endpoint            = "46.136.62.166:51820";  # External.
  #      # endpoint          = "192.168.0.35:51820";   # Local.
  #      # allowedIPs        = [ "10.100.0.0/24" ];    # Only for secure access. 
  #      allowedIPs          = [ "0.0.0.0/0" "::/0" ]; # Full VPN. 
  #      persistentKeepalive = 25;
  #    }];
  #  };
  #};


  ### Sops for the wireguard private key.
  #sops.secrets.wg_private_key = {};
  #sops.templates."wg-env".content = ''
  #    WG_PRIVATE_KEY=${config.sops.placeholder.wg_private_key}
  #  '';
}
