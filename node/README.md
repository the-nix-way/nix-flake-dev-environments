# Node.js dev environment

Open up the provided Nix shell:

```shell
nix develop --ignore-environment
```

Once inside the shell, you can run standard [node] and [npm] commands:

```shell
npm install
node ./index.js
```

To use the Node.js environment without checking out this repo:

```shell
nix develop 'github:the-nix-way/nix-flake-dev-environments?dir=node'
```

[node]: https://nodejs.org
[npm]: https://npmjs.org
