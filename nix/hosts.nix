{ inputs, self, ... }:
{
  flake = { _, ... }: {
    nixosConfigurations = {
      rebost = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          inputs.disko.nixosModules.disko
          ../disko.nix
          ../modules/impermanence.nix
          {
            system.stateVersion = "25.05";
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            users.users.root = {
              password = "nixos";
            };
          }
          {
            # Bootloader.
            boot = {
              loader = {
                grub.enable = true;
                # systemd-boot.enable = true;
                # systemd-boot.configurationLimit = 5;
                # efi.canTouchEfiVariables = true;
              };
            };
          }
        ];
      };
    };
  };
}
