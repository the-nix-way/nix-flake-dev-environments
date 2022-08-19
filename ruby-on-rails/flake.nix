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

        ruby = pkgs.ruby_3_1; # Use a single version of Ruby throughout

        rubyEnv = bundlerEnv { # The full app environment with dependencies
          name = "rails-env";
          inherit ruby;
          gemdir = ./.; # Points to Gemfile.lock and gemset.nix
        };

        inherit (nix-filter.lib) filter;
        inherit (pkgs) bundlerEnv mkShell substituteAll writeScriptBin;
        inherit (pkgs.dockerTools) buildImage pullImage;
        inherit (pkgs.stdenv) mkDerivation;

        updateDeps = writeScriptBin "update-deps" (builtins.readFile
          (substituteAll {
            src = ./scripts/update.sh;
            bundix = "${pkgs.bundix}/bin/bundix";
            bundler = "${rubyEnv.bundler}/bin/bundler";
          }));
      in {
        devShells = rec {
          default = run;

          run = mkShell {
            buildInputs = [ rubyEnv rubyEnv.wrappedRuby updateDeps ];

            shellHook = ''
              ${rubyEnv}/bin/rails --version
            '';
          };
        };

        packages = {
          default = rubyEnv;

          docker = buildImage {
            name = "rails-app";
            tag = "latest";
            fromImage = pullImage {
              imageName = "alpine";
              finalImageTag = "3.15.15";
              imageDigest = "sha256:26284c09912acfc5497b462c5da8a2cd14e01b4f3ffa876596f5289dd8eab7f2";
              sha256 = "sha256-GI48WVALDbGycMtYJ8MM7WhmOiaWOZcU+cBf9EQ7tgY=";
            };

            copyToRoot = rubyEnv;
            config.Cmd = [ "/bin/rails" ];
          };
        };
      });
}
