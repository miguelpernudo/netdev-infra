{ config, ... }:

{
    programs.micro = {
      enable = true;
      settings = {
        colorscheme  = "ocean";
        tabsize      = 2;
        tabstospaces = true;
        autoindent   = true;
        savecursor   = true;
        saveundo     = true;
        scrollbar    = true;
        mouse        = true;
        softwrap     = true;
        hlsearch     = true;
        autosu       = true;
        clipboard    = "external";
      };
    };
  
  xdg.configFile."micro/colorschemes/ocean.micro".text = ''
    color-link default "#E0F2F1,#0B132B"
  	color-link comment "#4A6FA5"
  	color-link identifier "#48CAE4"
  	color-link constant "#A3DAB6"
  	color-link statement "#00B4D8"
  	color-link symbol "#CAF0F8"
  	color-link preproc "#90E0EF"
  	color-link type "#0077B6"
  	color-link special "#0096C7"
  	color-link underlined "underline #48CAE4"
  	color-link error "bold #EF233C"
  	color-link todo "bold #F4A261,#0B132B"
  	color-link hlsearch "#0B132B,#48CAE4"
  	color-link statusline "#CAF0F8,#03045E"
  	color-link tabbar "#CAF0F8,#03045E"
  	color-link indent-char "#1C2541"
  	color-link line-number "#4A6FA5,#0B132B"
  	color-link current-line-number "#CAF0F8,#1C2541"
    color-link cursor-line "#1C2541"
    color-link color-column "#1C2541"
    color-link divider "#03045E,#03045E"
  '';
}
