{ config, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    vscodium
    opencode-desktop
    lazygit

    go
    gopls
    gotools
    delve

    ansible
    ansible-lint
  ];
}
