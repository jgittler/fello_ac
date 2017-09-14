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
        adapter: Swoosh.Adapters.Local,
        relay: "localhost:4000",
        username: "contact@felloeyewear.com",
        password: {:system, "EMAIL_PASSWORD"},
        tls: :always

