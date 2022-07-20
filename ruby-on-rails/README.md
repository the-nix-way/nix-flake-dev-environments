# Ruby on Rails dev environment

Open up the provided Nix shell:

```shell
nix develop --ignore-environment
```

Once inside the shell, you can run the Rails app:

```shell
./bin/rails server
```

To use the Rails environment without checking out this repo:

```shell
nix develop 'github:the-nix-way/nix-flake-dev-environments?dir=ruby-on-rails'
```

Note that this environment only works in conjunction with an existing `Gemfile`, `Gemfile.lock`, and `gemset.nix`.

## Updating dependencies

To make updates to the app's dependencies, such as bumping the Rails version, there's a special `update` shell for that:

```shell
nix develop .#update
```

Inside the shell, run the provided update script:

```shell
update-deps
```

Once the new `Gemfile.lock` and `gemset.nix` have been created, then opening up the default shell using `nix develop` should work as expected but with the new dependencies.
