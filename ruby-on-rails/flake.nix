{
  description = "Ruby on Rails development environment";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, gitignore }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        inherit (gitignore.lib) gitignoreSource;
        inherit (pkgs) bundlerEnv mkShell;
        inherit (pkgs.lib) inNixShell;
        inherit (pkgs.stdenv) mkDerivation;

        ruby = pkgs.ruby_3_0; # Use a single version of Ruby throughout

        gems = bundlerEnv { # The full app environment with dependencies
          name = "rails-env";
          inherit ruby;
          gemdir = ./.; # Points to Gemfile.lock and gemset.nix
          copyGemFiles = true; # Not sure if this is necessary
        };
      in {
        packages = rec {
          default = railsApp;

          railsApp = mkDerivation {
            name = "nix-flake-rails-app";
            src = gitignoreSource ./.;
            env = gems;
            buildInputs = [
              gems
              gems.wrappedRuby
            ] ++ (with pkgs; [
              bundler
            ]);

            installPhase = ''
              mkdir -p $out
              cp -a . $out
            '';
          };
        };

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
