# Java dev environment

Open up the provided Nix shell:

```shell
nix develop --ignore-environment
```

Once inside the shell, you can run standard [Java] commands:

```shell
java

gradle

mvn
```

To use the Java environment without checking out this repo:

```shell
nix develop 'github:the-nix-way/nix-flake-dev-environments?dir=java'
```

[java]: https://docs.oracle.com/java
