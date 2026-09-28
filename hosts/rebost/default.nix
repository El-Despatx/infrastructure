{ user, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./impermanence.nix
    ../../modules/backups.nix
    ../../modules/openssh.nix
    ../../modules/tailscale.nix
    ../../modules/observability.nix
  ];
  boot.loader.grub.enable = true;
  system.stateVersion = "25.05";
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.enableAllTerminfo = true;

  networking.hostName = "rebost";

  environment.systemPackages = with pkgs; [
    wget
    curl
    neovim
    dua
    git
    gnumake
    htop
    file
    zip
    unzip
  ];

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
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMwPiy0p4GqkQ8lQpU7WjZ95U7H5xIisuC7Cu/Hgk8wr cardno:25_555_331" # pablo

          # Extra key for deploying via CI/CD with opentofu (via pablito2020/nixcfg opentofu deployment, ask him).
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICC1H566vc/DPR+rCXM8ciEf3h1s5+vaEXA2r5NZcaWE bot@opentofu"
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
