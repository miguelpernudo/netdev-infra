{ config, pkgs, pkgs-unstable, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs-unstable.chromium;

    # uBlock Lite and ClearURLs
    extensions = [
      { id = "ddkjiahejlhfcafbddmgiahcphecmpbg"; }
      { id = "lptnjkdhogmciknlfofhkjcmlhdndkhk"; }
    ];

    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
      "--no-pings"
      "--no-first-run"
      "--disable-sync"                
      "--disable-background-networking"
    ];
  };
}
