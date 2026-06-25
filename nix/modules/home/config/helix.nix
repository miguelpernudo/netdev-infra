{ config, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "oceanic-next";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        soft-wrap.enable = true;
        true-color = true;
      };
    };
  };
}
