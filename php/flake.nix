{
  description = "A Nix-flake-based PHP development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
    php-shell.url = "github:loophp/nix-shell";
  };

  outputs = { self, nixpkgs, flake-utils, php-shell }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };

          php = (php-shell.api.makePhp system {
            php = "php81";
            withExtensions = [ "pcov" "xdebug" ];
            withoutExtensions = [ "sodium" ];
            extraConfig = ''
              memory_limit=-1
            '';
            flags = {
              apxs2Support = false;
              ztsSupport = false;
            };
          });

          phpTools = with php.packages; [
            composer
          ];
        in {
          devShells = {
            default = pkgs.mkShell {
              # Packages included in the environment
              buildInputs = [
                php
              ] ++ phpTools;

              # Run when the shell is started up
              shellHook = ''
                echo "Entering PHP env:"
                echo ""
                ${php}/bin/php --version
                echo ""
              '';
            };
          };
        }
      );
}
