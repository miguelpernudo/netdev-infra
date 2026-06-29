{ lib, ... }:

# Disko declarative disk partitioning.
# Run disko before nixos-install.

{
  virtualisation.vmVariant = {
      disko.enableConfig = lib.mkForce false;
  };
  
  disko.devices = {
    disk.main = {
      device = "/dev/sda";  # FIXME: lsblk
      type   = "disk";
      content = {
        type = "gpt";
        partitions = {

       #   boot = {
       #     size = "1M";
       #     type = "EF02";
       #   };

          esp = {
            size     = "512M";
            type     = "EF00";
            content  = {
              type   = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          swap = {
            size    = "8G";
            content = {
              type   = "swap";
              resumeDevice = false;
            };
          };

          root = {
            size    = "100%";
            content = {
              type       = "filesystem";
              format     = "ext4";
              mountpoint = "/";
              extraArgs  = [ "-L" "nixos" ];
            };
          };

        };
      };
    };

    #disk.data = {
    #      device = "/dev/sdb";  # FIXME: lsblk
    #      type   = "disk";
    #      content = {
    #        type = "gpt";
    #        partitions = {
    #          data = {
    #            size    = "100%";
    #            content = {
    #              type       = "filesystem";
    #              format     = "ext4";
    #              mountpoint = "/data";
    #              extraArgs  = [ "-L" "data" ];
    #            };
    #          };
    #        };
    #      };
    #    };
  };
}
