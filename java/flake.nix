{
  description = "A Nix-flake-based Java development environment";

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

          java = pkgs.jdk17_headless;

          others = with pkgs; [
            gradle
            maven
          ];
        in {
          devShells = {
            default = pkgs.mkShell {
              # Packages included in the environment
              buildInputs = [
                java
              ] ++ others;

              shellHook = ''
                echo "Entering Java env"
                echo "Running ${java}/bin/java -version"
              '';
            };
          };
        }
      );
}
