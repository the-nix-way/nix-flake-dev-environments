{
  description = "Bazel development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        bazelPkg = pkgs.bazel_5;

        inherit (pkgs) mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [
              bazelPkg
            ];

            shellHook = ''
              ${bazelPkg}/bin/bazel --version
            '';
          };
        };
      }
    );
}
