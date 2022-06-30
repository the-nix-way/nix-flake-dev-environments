# Rust shell environment

Open up a shell:

```shell
nix develop .
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

> This flake doesn't convert the Rust dependencies into Nix dependencies. It only provides a "pure" Nix environment for using [Cargo].

[cargo]: https://cargo.rs
