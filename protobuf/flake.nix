{
  description = "A Nix-flake-based Protobuf development environment";

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
          inherit (pkgs) buf protobuf;
        in {
          devShells = {
            default = pkgs.mkShell {
              # Packages included in the environment
              buildInputs = with pkgs; [
                buf
                protobuf
              ];

              # Run when the shell is started up
              shellHook = ''
                echo "Entering Protobuf env"
                echo "Running Buf `${buf}/bin/buf --version`"
                echo "Running protoc `${protobuf}/bin/protoc --version`"
              '';
            };
          };
        }
      );
}
