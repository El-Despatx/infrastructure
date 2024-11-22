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
          ../hosts/rebost/default.nix
        ];
      };
    };
  };
}
