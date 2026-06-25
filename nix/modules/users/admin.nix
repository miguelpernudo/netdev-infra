{ config, pkgs, ... }:

{
  users.users.admin = {
    isNormalUser = true;
    extraGroups  = [ "wheel" ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILikxJU3A1o+jDG1y1blaFzZTxfznB+PMLwUJUDZCz/1 miguel@anatta"
    ]; 
    initialPassword = "nixos";
  };
}
