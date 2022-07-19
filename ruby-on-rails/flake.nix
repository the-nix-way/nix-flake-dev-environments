{
  description = "TODO";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) bundlerEnv mkShell;
        ruby = pkgs.ruby_3_0;

        gems = bundlerEnv {
          name = "rails-env";
          inherit ruby;
          gemdir = ./.;
          copyGemFiles = true;
        };
      in {
        devShells = {
          default = mkShell {
            buildInputs = with pkgs; [
              gems
              gems.wrappedRuby
            ];
          };

          update = mkShell {
            buildInputs = [ ruby ] ++ (with pkgs; [ bundix bundler ruby ]);
          };
        };
      }
    );
}
