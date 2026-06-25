{ config, pkgs, lib, ... }:

# Nix defines persistent policies via a systemd service
# that runs a script at startup.

{
  options.services.traffic-control = {
    enable = lib.mkEnableOption "Traffic Control";

    script = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "tc script executed on network.target startup";
    };
  };

  config = lib.mkIf config.services.traffic-control.enable {
    environment.systemPackages = with pkgs; [ iproute2 ];

    systemd.services.traffic-control = {
      description = "tc QoS rules";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      serviceConfig.RemainAfterExit = true;
      script = config.services.traffic-control.script;
    };
  };
}
