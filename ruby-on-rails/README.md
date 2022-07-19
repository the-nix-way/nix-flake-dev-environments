# Ruby on Rails environment

## How to update versions

```shell
nix develop .#update

# Inside the Nix shell
rm Gemfile.lock gemset.nix
bundle lock
bundix -l
```
