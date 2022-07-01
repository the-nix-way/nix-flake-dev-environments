# Python

Start up the pure development shell:

```shell
nix develop --ignore-environment
```

Once inside the shell, you can run standard Python commands:

```shell
python ./main.py
```

To use the Python environment without checking out this repo:

```shell
nix develop 'github:the-nix-way/nix-flake-dev-environments?dir=python'
```
