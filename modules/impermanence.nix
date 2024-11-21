{ inputs, lib, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  # boot.initrd.postDeviceCommands = lib.mkAfter ''
  #   mkdir /btrfs_tmp
  #   mount /dev/root_vg/root /btrfs_tmp
  #   if [[ -e /btrfs_tmp/root ]]; then
  #       mkdir -p /btrfs_tmp/old_roots
  #       timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
  #       mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
  #   fi
  #
  #   delete_subvolume_recursively() {
  #       IFS=$'\n'
  #       for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
  #           delete_subvolume_recursively "/btrfs_tmp/$i"
  #       done
  #       btrfs subvolume delete "$1"
  #   }
  #
  #   for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
  #       delete_subvolume_recursively "$i"
  #   done
  #
  #   btrfs subvolume create /btrfs_tmp/root
  #   umount /btrfs_tmp
  # '';

  # Fix agenix ssh key being not mounted when agenix was running
  # fileSystems."/etc/nixos" = {
  #   depends = [ "/persist" ];
  #   neededForBoot = true;
  # };

  # Issue: https://github.com/nix-community/impermanence/issues/229
  # Can't use bind with machine-id...
  # systemd.tmpfiles.rules = [
  #   "L /etc/machine-id - - - - /persist/etc/machine-id"
  # ];

  # fileSystems."/persist".neededForBoot = true;
  # environment.persistence."/persist/system" = {
  #   hideMounts = true;
  #   directories = [
  #     "/etc/nixos"
  #     "/var/log"
  #     "/etc/secureboot" # we're using lanzaboote
  #     "/var/lib/bluetooth"
  #     "/var/lib/nixos"
  #     "/var/lib/systemd/coredump"
  #     "/etc/NetworkManager/system-connections"
  #   ];
  #   files = [
  #     # "/etc/machine-id"
  #     { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
  #   ];
  # };

  # programs.fuse.userAllowOther = true;
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
