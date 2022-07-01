# Rust dev environment

Open up the provided Nix shell:

```shell
nix develop --ignore-environment
```

Once inside the shell, you can run standard [Cargo] commands:

```shell
# Run the main.rs executable
cargo run

# Build and run
cargo build
./target/debug/nix-flakes-rust

# Build and run a release
cargo build --release
./target/release/nix-flakes-rust
```

To use the Rust environment without checking out this repo:

```shell
nix develop 'github:the-nix-way/nix-flake-dev-environments?dir=rust'
```

[cargo]: https://crates.io/
