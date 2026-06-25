{ config, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      font-size   = 12;

      background             = "#0d1b2a";
      foreground             = "#c8d8e8";
      cursor-color           = "#4fc3f7";
      cursor-text            = "#0d1b2a";
      selection-background   = "#1a3a5c";
      selection-foreground   = "#e0f0ff";
      
      palette = [
        "0=#0d1b2a"
        "1=#ef5350"
        "2=#26c6da"
        "3=#ffa726"
        "4=#1e88e5"
        "5=#5c6bc0"
        "6=#00acc1"
        "7=#b0bec5"
        "8=#263238"
        "9=#ff7043"
        "10=#4dd0e1"
        "11=#ffca28"
        "12=#42a5f5"
        "13=#7986cb"
        "14=#26c6da"
        "15=#eceff1"
      ];

      window-padding-x       = 12;
      window-padding-y       = 10;
      window-decoration      = "server";

      scrollback-limit       = 10000;
      copy-on-select         = true;
    };
  };
}
