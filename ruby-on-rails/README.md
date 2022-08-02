# Ruby on Rails dev environment

Open up the provided Nix shell:

```shell
nix develop --ignore-environment
```

Alternatively, you can run `direnv allow` to activate the shell in your current environment.

Then you can run the Nix-bundled Rails app by just running `rails`. The standard `./bin/rails` also works.

To use the Rails environment without checking out this repo:

```shell
nix develop 'github:the-nix-way/nix-flake-dev-environments?dir=ruby-on-rails'
```

Note that this environment only works in conjunction with an existing `Gemfile`, `Gemfile.lock`, and `gemset.nix`. If you have a `Gemfile.lock` but no `gemset.nix`:

```shell
nix run nixpkgs#bundix
```

## Updating dependencies

To make updates to the app's dependencies, such as bumping the Rails version, there's a special script that generates a new `Gemfile.lock` and `gemset.nix`:

```shell
update-deps
```

Once the new `Gemfile.lock` and `gemset.nix` have been created, then opening up the default shell using `nix develop` should work as expected but with the new dependencies.

