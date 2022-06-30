{
  description = "A Nix-flake-based Go development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              # Go version 1.18
              go_1_18

              # goimports, godoc, etc.
              gotools

              # https://github.com/golangci/golangci-lint
              golangci-lint

              # The Go language server (for IDEs and such)
              gopls

              # https://pkg.go.dev/github.com/ramya-rao-a/go-outline
              go-outline

              # https://github.com/uudashr/gopkgs
              gopkgs
            ];
            
            shellHook = ''
              echo "Running `${pkgs.go_1_18}/bin/go version`"
            '';
          };
        }
      );
}
