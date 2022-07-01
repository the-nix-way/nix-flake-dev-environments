# Go

Start up the pure development shell:

```shell
nix develop --ignore-environment
```

To use the Go environment without checking out this repo:

```shell
nix develop 'github:the-nix-way/nix-flake-dev-environments?dir=go'
```

Original inspiration:

https://github.com/amboss-mededu/go-pipeline-article/blob/365821eae377dc866e8f3d8b51e8f8375ce62e31/flake.nix
