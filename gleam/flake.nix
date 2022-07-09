{
  description = "Gleam";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        apps = {
          default = {
            type = "app";
            program = "${pkgs.gleam}/bin/gleam";
          };
        };

        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              erlang
              gleam
              rebar3
            ];

            shellHook = ''
              cat << EOF
              Entering Gleam env. Running:

              `${pkgs.gleam}/bin/gleam --version`
              EOF
            '';
          };
        };
      }
    );
}
