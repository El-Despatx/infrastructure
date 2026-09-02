{
  disko.devices = {
    disk.hdd = {
      type = "disk";
      device = "/dev/disk/by-id/wwn-0x600508b1001cebd3cb9241b484b91f97";
      content = {
        type = "gpt";
        partitions = {
          MBR = {
            type = "EF02"; # for grub MBR
            size = "1M";
            priority = 1; # Needs to be first partition
          };
          root = {
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "root_vg";
            };
          };
          swap = {
            size = "4G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
        };
      };
    };

    disk.data = {
      type = "disk";
      device = "/dev/disk/by-id/wwn-0x600508b1001c8defb80b6bf96bc5781f";
      content = {
        type = "gpt";
        partitions = {
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/data";
              mountOptions = [ "noatime" ];
            };
          };
        };
      };
    };

    lvm_vg = {
      root_vg = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                };
                "/persist" = {
                  mountOptions = [
                    "subvol=persist"
                    "noatime"
                  ];
                  mountpoint = "/persist";
                };
                "/nix" = {
                  mountOptions = [
                    "subvol=nix"
                    "noatime"
                  ];
                  mountpoint = "/nix";
                };
                "/boot" = {
                  mountOptions = [
                    "subvol=boot"
                    "noatime"
                  ];
                  mountpoint = "/boot";
                };
              };
            };
          };
        };
      };
    };

  };
}
