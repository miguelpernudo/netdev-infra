# Isolated generic guest user.

{ config, pkgs, ... }:

{
  users.users.guest = {
    isNormalUser = true;
    description = "Invitado";
    password = "221021";
    extraGroups = ["networkmanager" "video" "audio" ];
  };
}
