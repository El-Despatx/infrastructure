{inputs, self, ...}:
{
    rebost = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
            ../modules/impermanence.nix
            {
                system.stateVersion = "24.05";
                nix.extraOptions = ''
                    experimental-features = nix-command flakes
                '';
                users.users.root = {
                    password = "nixos";
                };
            }
        ];
    };
}
