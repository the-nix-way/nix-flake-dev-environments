{
  description = "A Nix-flake-based Python development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
    mach-nix.url = "github:DavHau/mach-nix";
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };

          python = pkgs.python39;

          pythonEnv = mach-nix.lib.${system}.mkPython {
            requirements = builtins.readFile ./requirements.txt;
          };

          pythonTools = with pkgs.python39Packages; [
            pip
            virtualenv
          ];
        in {
          devShells = {
            default = pkgs.mkShell {
              # Packages included in the environment
              buildInputs = [
                pythonEnv
              ] ++ pythonTools;

              # Run when the shell is started up
              shellHook = ''
                echo "Running `${python}/bin/python --version`"
              '';
            };
          };

          packages = {
            venv = pythonEnv;
          };

          defaultPackage = mach-nix.lib.${system}.mkPythonShell {
            requirements = builtins.readFile ./requirements.txt;
          };
        }
      );
}
