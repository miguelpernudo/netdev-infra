{ config, lib, ... }:

{
  imports = [
    ./locale.nix
    ./nix.nix
    ./settings.nix
  ];
  
  sops.age.sshKeyPaths = lib.mkDefault [ "/etc/ssh/ssh_host_ed25519_key" ];
}
