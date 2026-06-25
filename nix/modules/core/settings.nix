{ lib, ... }: 

# Global settings defined on each host. 
# The hostname is defined by the flake. The user is managed manually.
{
  options.mySettings = {
    locale   = lib.mkOption { type = lib.types.str; default = "en_US.UTF-8"; };
    timeZone = lib.mkOption { type = lib.types.str; default = "UTC"; };
    keyMap   = lib.mkOption { type = lib.types.str; default = "en"; };

    rescueDisableServices = lib.mkOption {type = lib.types.listOf lib.types.str; default = []; };

    nix = {
      gcDates     = lib.mkOption { type = lib.types.str; default = "weekly"; };
      deleteOlder = lib.mkOption { type = lib.types.str; default = "14d"; };
      autoUpgrade = lib.mkEnableOption "Enable nix autoupgrade";
      useNixld    = lib.mkEnableOption "Enable nix-ld";
    };
  };
}
