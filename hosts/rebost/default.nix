{ user, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./impermanence.nix
    ../../modules/ssh.nix
  ];
  boot.loader.grub.enable = true;
  system.stateVersion = "25.05";
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';


  programs = {
    zsh.enable = true;
    direnv = {
      enable = true;
      silent = true;
      direnvrcExtra = ''
        echo "Loaded Environment! 󱄅";
      '';
    };
  };
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
      root = {
        password = "nixos";
      };
      ${user} = {
        password = "changeme1234";
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };
  };
}
