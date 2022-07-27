{
  description = "Nix flake dev environments";

  outputs = { self }: {
    templates = rec {
      gleam = {
        path = ./gleam;
        description = "Gleam development environment";
      };

      go = {
        path = ./go;
        description = "Go development environment";
      };

      java = {
        path = ./java;
        description = "Java development environment";
      };

      node = {
        path = ./node;
        description = "Node.js development environment";
      };

      php = {
        path = ./php;
        description = "PHP development environment";
      };

      protobuf = {
        path = ./protobuf;
        description = "Protocol Buffers development environment";
      };

      python = {
        path = ./python;
        description = "Python development environment";
      };

      ruby-on-rails = {
        path = ./ruby-on-rails;
        description = "Ruby on Rails development environment";
      };

      rust = {
        path = ./rust;
        description = "Rust development environment";
      };
    };
  };
}
