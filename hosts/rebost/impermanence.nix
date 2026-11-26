{ inputs, pkgs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services.rollback-root = {
    description = "Archive and recreate the root Btrfs subvolume";
    requiredBy = [ "sysroot.mount" ];
    requires = [ "dev-root_vg-root.device" ];
    after = [ "dev-root_vg-root.device" "initrd-root-device.target" "systemd-hibernate-resume.service" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";
    path = [ pkgs.btrfs-progs pkgs.coreutils pkgs.findutils pkgs.util-linux.mount ];
    script = ''
      set -euo pipefail
      mkdir -p /btrfs_tmp
      mount -o subvolid=5 /dev/root_vg/root /btrfs_tmp
      trap 'umount /btrfs_tmp' EXIT

      mkdir -p /btrfs_tmp/old_roots
      if [[ -e /btrfs_tmp/root || -L /btrfs_tmp/root ]]; then
        btrfs subvolume show /btrfs_tmp/root > /dev/null
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        archive="/btrfs_tmp/old_roots/$timestamp"
        suffix=0
        while [[ -e "$archive" || -L "$archive" ]]; do
          suffix=$((suffix + 1))
          archive="/btrfs_tmp/old_roots/$timestamp-$suffix"
        done
        mv -T /btrfs_tmp/root "$archive"
      fi

      find /btrfs_tmp/old_roots -mindepth 1 -maxdepth 1 -type d -mtime +30 \
        -exec btrfs subvolume delete --recursive -- {} +

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
      trap - EXIT
    '';
  };

  # Issue: https://github.com/nix-community/impermanence/issues/229
  # Can't use bind with machine-id...
  systemd.tmpfiles.rules = [
    "L /etc/machine-id - - - - /persist/etc/machine-id"
  ];

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/etc/secureboot" # we're using lanzaboote
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/home/pofnet/projects"
      "/home/pofnet/data"
      "/root/.ssh"
      "/home/pofnet/.ssh"
      "/var/lib/tailscale"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      # "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  programs.fuse.userAllowOther = true;
  # home-manager.users.${user} = {
  #   imports = [
  #     inputs.impermanence.nixosModules.home-manager.impermanence
  #   ];
  #   home.persistence."/persist/home" = {
  #     directories = [
  #       "Downloads"
  #       "projects"
  #       ".gnupg"
  #       ".ssh"
  #       ".local/share/keyrings"
  #       ".local/share/direnv"
  #     ];
  #     files = [
  #       ".screenrc"
  #     ];
  #     allowOther = true;
  #   };
  # };

}
