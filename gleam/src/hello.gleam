import gleam/io

fn hello() -> Nil {
  "Hello, world"
  |> io.println

  Nil
}

pub fn main() {
  hello()
}
