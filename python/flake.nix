{
  description = "A Nix-flake-based Python development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };

          python = pkgs.python39;

          others = with pkgs.python39Packages; [
            pip
            virtualenv
          ];
        in {
          devShells = {
            default = pkgs.mkShell {
              # Packages included in the environment
              buildInputs = [
                python
              ] ++ others;

              # Run when the shell is started up
              shellHook = ''
                echo "Running `${python}/bin/python --version`"
              '';
            };
          };
        }
      );
}
