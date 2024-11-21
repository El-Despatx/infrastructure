{
  disko.devices = {
    disk = {
      operating_system = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "mbr";
          partitions = {
            swap = {
                size = "4G";
                content = {
                  type = "swap";
                  resumeDevice = true;
                };
            };
            impermanence_group_volume = {
              name = "root";
              size = "100%";
              content = {
                  type = "lvm_pv";
                  vg = "root_vg";
              };
            };
          };
        };
      };
      hardware_data_raid = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            root = {
                size = "100%";
                content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/data";
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
                        mountOptions = [ "subvol=persist" "noatime" ];
                        mountpoint = "/persist";
                      };
                      "/nix" = {
                        mountOptions = [ "subvol=nix" "noatime" ];
                        mountpoint = "/nix";
                      };
                    };
                  };
                };
              };
            };
       };
    };
  };
}
