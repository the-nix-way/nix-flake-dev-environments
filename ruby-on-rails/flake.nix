{
  description = "Ruby on Rails development environment";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";
  };

  outputs = { self, nixpkgs, flake-utils, nix-filter }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        ruby = pkgs.ruby_3_0; # Use a single version of Ruby throughout

        rubyEnv = bundlerEnv { # The full app environment with dependencies
          name = "rails-env";
          inherit ruby;
          gemdir = ./.; # Points to Gemfile.lock and gemset.nix
          copyGemFiles = true; # Not sure if this is necessary
        };

        inherit (nix-filter.lib) filter;
        inherit (pkgs) bundlerEnv mkShell substituteAll writeScriptBin;
        inherit (pkgs.stdenv) mkDerivation;

        updateScript = builtins.readFile (substituteAll {
          src = ./scripts/update.sh;
          bundix = "${pkgs.bundix}/bin/bundix";
          bundler = "${rubyEnv.bundler}/bin/bundler";
        });

        updateScriptBin = writeScriptBin "update-deps" updateScript;
      in {
        apps = {
          default = {
            type = "app";
            program = "${self.packages.${system}.default}/bin/rails";
          };
        };

        devShells = rec {
          default = run;

          run = mkShell {
            buildInputs = [
              rubyEnv
              rubyEnv.wrappedRuby
            ];
          };

          update = mkShell {
            buildInputs = [
              ruby
              updateScriptBin
            ] ++ (with pkgs; [
              bundler-audit
            ]);
          };
        };
      }
    );
}
