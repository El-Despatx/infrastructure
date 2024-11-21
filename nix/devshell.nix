{ inputs, self, ... }: {

  perSystem = { system, ... }:
    let
      pkgs = import inputs.nixpkgs-unstable {
        inherit system;
        # config.allowUnfree = true;
      };
    in
    {
      checks.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ../.;
        hooks = {
          nixpkgs-fmt.enable = true;
          commitizen.enable = true;
        };
      };
      devShells.default = pkgs.mkShell {
        name = "nixcfg";
        packages = [ pkgs.gnumake pkgs.git pkgs.openssh pkgs.nixos-anywhere ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
      formatter = pkgs.nixpkgs-fmt;
    };
}
