{ inputs, ... }: {
  perSystem =
    { pkgs
    , system
    , ...
    }: {
      packages.live-iso = inputs.nixos-generators.nixosGenerate {
        pkgs = (import inputs.nixpkgs-unstable) {
          system = "x86_64-linux";
        };
        system = "x86_64-linux";
        specialArgs = {
          user = "root";
        };
        modules = [
          {
            system.stateVersion = "24.11";
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            users.users.root = {
              password = "nixos";
            };
          }
          {
            services.openssh = {
              enable = true;
            };
            # users.users.${user}.openssh.authorizedKeys.keys = [
            #   (builtins.readFile ../../../static/gpg-ssh.pub)
            # ];
          }
        ];
        format = "install-iso";
      };
    };
}

