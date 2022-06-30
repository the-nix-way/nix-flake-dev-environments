{
  description = "A Nix-flake-based Rust development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
    # A utility library for working with Rust
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          # This overlay adds the "rust-bin" package to nixpkgs
          (import rust-overlay)
        ];

        # System-specific nixpkgs with rust-overlay applied
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        # Use the specific version of the Rust toolchain specified by the toolchain file
        localRust = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in {
        # The shell environment
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [
              localRust

              # Other utilities commonly used in Rust projects (but not this one)
              pkgs.openssl
            ];

            shellHook = ''
              echo "Running `${localRust}/bin/cargo --version`"
            '';
          };
        };      
      }
    );
}
