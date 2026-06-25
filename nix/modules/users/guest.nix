# Usuario genérico aislado

{ config, pkgs, ... }:

{
  users.users.invitado = {
    isNormalUser = true;
    description = "Invitado";
    password = "221021";
    extraGroups = ["networkmanager" "video" "audio" ];
  };
}
