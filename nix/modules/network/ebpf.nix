{ config, pkgs, lib, ... }:

{
  options.services.ebpf.enable = lib.mkEnableOption "eBPF/BCC toolkit";

  config = lib.mkIf config.services.ebpf.enable {
    environment.systemPackages = with pkgs; [
      bcc
      bpftrace
    ];
  };
}
