{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./impermanence.nix
  ];
  boot.loader.grub.enable = true;
  system.stateVersion = "25.05";
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  users.users.root = {
    password = "nixos";
  };
}
