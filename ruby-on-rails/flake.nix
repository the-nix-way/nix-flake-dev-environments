{
  description = "TODO";

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

        ruby = pkgs.ruby_3_0;

        gems = bundlerEnv {
          name = "rails-env";
          inherit ruby;
          gemdir = ./.;
          copyGemFiles = true;
        };
      in {
        packages = rec {
          default = railsApp;

          railsApp = mkDerivation {
            name = "nix-flake-rails-app";
            src = if inNixShell then null else gitignoreSource ./.;
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
            buildInputs = [ ruby ] ++ (with pkgs; [ bundix bundler-audit bundler ruby ]);
          };
        };
      }
    );
}
