{ config, ... }:

{
  programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source  = "nixos";
          # source  = "/home/miguel/Imágenes/ascii/tibu3.txt";
          padding = { top = 1; right = 5; left = 1; };
        };
        display = {
          separator = " ~~ ";
          color = {
            keys  = "cyan";
            title = "blue";
          };
        };
        modules = [
          "title"
          { type = "custom"; format = "╭───────────────────────────────────────────────────────╮"; }
          
          # SISTEMA
          { type = "os";       key = " ";  keyColor = "blue"; }
          { type = "kernel";   key = " ";  keyColor = "cyan"; } 
          { type = "uptime";   key = "󰔚 ";  keyColor = "blue"; } 
          { type = "shell";    key = " ";  keyColor = "cyan"; }
          { type = "packages"; key = " ";  keyColor = "blue"; }
          
          { type = "custom"; format = "├───────────────────────────────────────────────────────┤"; keyColor = "cyan"; }
          
          # INTERFAZ
          { type = "de";       key = " ";  keyColor = "blue"; }
          { type = "font";    key = "󰛖 ";  keyColor = "cyan"; }
          { type = "terminal"; key = " ";  keyColor = "blue"; }
          { type = "icons";    key = "󰇞 ";  keyColor = "cyan"; }
          { type = "cursor";   key = " ";  keyColor = "blue"; } 
          
          { type = "custom"; format = "├───────────────────────────────────────────────────────┤"; keyColor = "cyan"; }
          
          # HARDWARE
          { type = "host";     key = " ";  keyColor = "blue"; format = "{version}"; }
          { type = "cpu";      key = "󰻠 ";  keyColor = "cyan"; }
          { type = "gpu";      key = "󰍛 ";  keyColor = "blue"; }
          { type = "memory";   key = " ";  keyColor = "cyan"; }
          { type = "disk";     key = "󰋊 ";  keyColor = "blue"; } 
          
          { type = "custom"; format = "╰───────────────────────────────────────────────────────╯"; keyColor = "cyan"; }
          "break"
          
          { type = "colors"; symbol = "square"; }
        ];
      };
    };
}
