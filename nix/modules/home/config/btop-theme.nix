{ config, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      truecolor = true;
      preset0   = "cpu:0:default,mem:0:default,net:0:default,proc:0:default";
      graph_symbol = "braille";
      update_ms    = 1500;
      proc_sorting = "cpu lazy";
      proc_tree   = true;
      check_temp  = true;
      cpu_sensor  = "Auto";
      show_disks  = true;
      symbols_graph_column = true;
      canvas_symbol = "braille";
      colorscheme  = "ocean";
    };
  };
  
  xdg.configFile."btop/themes/ocean.theme".text = ''
      # Main colors
      theme[main_bg]="#1b2b34"
      theme[main_fg]="#d8dee9"
      theme[title]="#ffffff"
      theme[hi_fg]="#6699cc"
      theme[selected_bg]="#4f5b66"
      theme[selected_fg]="#ffffff"
      theme[inactive_fg]="#65737e"
      theme[graph_text]="#6699cc"
      theme[table_header]="#6699cc"
      theme[proc_misc]="#6699cc"
      
      # CPU Graph colors
      theme[cpu_start]="#6699cc"
      theme[cpu_mid]="#5fb3b3"
      theme[cpu_end]="#99c794"
      
      # Mem and GPU
      theme[mem_start]="#6699cc"
      theme[mem_mid]="#4f5b66"
      theme[mem_end]="#1b2b34"
  '';
}
