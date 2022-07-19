{
  description = "Ruby on Rails development environment";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        ruby = pkgs.ruby_3_0; # Use a single version of Ruby throughout

        gems = bundlerEnv { # The full app environment with dependencies
          name = "rails-env";
          inherit ruby;
          gemdir = ./.; # Points to Gemfile.lock and gemset.nix
          copyGemFiles = true; # Not sure if this is necessary
        };

        inherit (pkgs) bundlerEnv mkShell; # Inheritance helper
      in {
        devShells = rec {
          default = run;

          run = mkShell {
            buildInputs = [
              gems
              gems.wrappedRuby
            ] ++ (with pkgs; [ sqlite ]);
          };

          update = mkShell {
            buildInputs = [ ruby ] ++ (with pkgs; [ bundix bundler-audit bundler ]);
          };
        };
      }
    );
}
