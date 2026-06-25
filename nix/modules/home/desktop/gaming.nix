{ config, pkgs-unstable, ... }:

{
    home.packages = with pkgs-unstable; [
      # lutris
      protonup-rs
      eden
      ryubing
    ];
}
