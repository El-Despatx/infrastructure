{ user, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./impermanence.nix
    ../../modules/backups.nix
    ../../modules/openssh.nix
    ../../modules/tailscale.nix
  ];
  boot.loader.grub.enable = true;
  system.stateVersion = "25.05";
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.enableAllTerminfo = true;

  networking.hostName = "rebost";

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
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDO11F5Mw0JYYi/IgmgfV7bRZS7yDi5y/FSDpM3Ep6Qt openpgp:0xBC69F42C" # ferran
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2SPPa9ZAtAGTuprKx2vKL+PK1aPm/LPveJXBYNOXUF oriolagobat@lift" # ori
        ];
      };
      ${user} = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };
  };
}
