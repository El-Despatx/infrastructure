{
  disko.devices = {
    disk.ssd = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          MBR = {
            type = "EF02"; # for grub MBR
            size = "1M";
            priority = 1; # Needs to be first partition
          };
          ESP = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          swap = {
            size = "4G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
          # impermanence_group_volume = {
          #   size = "100%";
          #   content = {
          #     type = "lvm_pv";
          #     vg = "root_vg";
          #   };
          # };
        };
      };
    };

    disk.data = {
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
            };
          };
        };
      };
    };

    # lvm_vg = {
    #   root_vg = {
    #     type = "lvm_vg";
    #     lvs = {
    #       root = {
    #         size = "100%FREE";
    #         content = {
    #           type = "btrfs";
    #           extraArgs = [ "-f" ];
    #           subvolumes = {
    #             "/root" = {
    #               mountpoint = "/";
    #             };
    #             "/persist" = {
    #               mountOptions = [ "subvol=persist" "noatime" ];
    #               mountpoint = "/persist";
    #             };
    #             "/nix" = {
    #               mountOptions = [ "subvol=nix" "noatime" ];
    #               mountpoint = "/nix";
    #             };
    #           };
    #         };
    #       };
    #     };
    #   };
    # };

  };
}
