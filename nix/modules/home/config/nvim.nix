# DOESN'T WORK IN 26.05
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;
     
    plugins = with pkgs.vimPlugins; [
      oceanic-next
      telescope-nvim
      oil-nvim
      gitsigns-nvim
      nvim-autopairs
      comment-nvim
    ];
    
    extraConfig = ''
      set termguicolors
      colorscheme OceanicNext
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set expandtab
    '';
  };
}
