{ config, pkgs, pkgs-unstable, ... }:

{
  programs.librewolf = {
    enable = true;
    package = pkgs-unstable.librewolf;
    
    settings = {
      "gfx.webrender.all" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      
      "media.hardware-video-decoding.enabled"     = true;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      
      "media.autoplay.default" = 5;
      "general.smoothScroll"   = true; 
    };
  };
}
