# Ruby on Rails dev environment

Open up the provided Nix shell:

```shell
nix develop --ignore-environment
```

Once inside the shell, you can run the Rails app:

```shell
./bin/rails server
```

To use the Rust environment without checking out this repo:

```shell
nix develop 'github:the-nix-way/nix-flake-dev-environments?dir=ruby-on-rails'
```
