{ config, pkgs, lib, ... }:

{
  networking.wireguard.interfaces.wg0 = {
    ips            = [ "10.100.0.1/24" ];  # FIXME
    listenPort     = 51820;
    privateKeyFile = config.sops.secrets.wg_private_key.path;

    peers = [
      # PC (orca)
      {
        publicKey  = "efVku/ZYcZimksoNCkMTcoZk4+XXhvo+rmwWZ9fGuhk=";
        allowedIPs = [ "10.100.0.2/32" ];
      }

      # Phone (via the wireguard app)
      {
        publicKey  = "GFL08U0fc3jfoW5k9VPUe8cWgYA69zRAmx1UqElJmB8=";
        allowedIPs = [ "10.100.0.3/32" ];
      }
    ];
    
    # Needed but already defined in 
    # ../networking/firewall-server.nix includes it.
    
    # postUp = ''
    #   nft add rule ip nat POSTROUTING oifname "enp2s0" masquerade
    # '';
    # preDown = ''
    #   nft flush chain ip nat POSTROUTING
    # '';
  };

  # Needed but already defined in ../../hosts/angler/boot.nix
  # boot.kernel.sysctl."net.ipv4.ip_forward" = lib.mkForce 1;

  sops.secrets.wg_private_key = {};

  # If using the nixos firewall.   
  # networking.firewall.allowedUDPPorts = [ 51820 ];
}
