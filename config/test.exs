use Mix.Config

config :fello_ac,
       secret: "secret"

config :fello_ac, FelloAc.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "fello_ac_test",
  username: "jasongittler",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
]

config :fello_ac, FelloAc.Mailer,
        adapter: Swoosh.Adapters.Test

