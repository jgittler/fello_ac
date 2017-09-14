use Mix.Config

config :fello_ac,
       secret: "secret"

config :fello_ac, FelloAc.Mailer,
        adapter: Swoosh.Adapters.Local,
        relay: "localhost:4000",
        username: "contact@felloeyewear.com",
        tls: :always
