defmodule ElixirPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :elixir_phoenix,
    adapter: Ecto.Adapters.Postgres
end
