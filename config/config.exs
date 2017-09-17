use Mix.Config

config :fello_ac,
       secret: System.get_env("SECRET"),
       port: 4000

config :fello_ac, :ecto_repos, [FelloAc.Repo]

config :fello_ac, FelloAc.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "fello_ac",
  username: "jasongittler",
  hostname: "localhost"
]

config :fello_ac, FelloAc.Mailer,
        adapter: Swoosh.Adapters.SMTP,
        relay: "smtp.gmail.com",
        username: "contact@felloeyewear.com",
        password: System.get_env("EMAIL_PASSWORD"),
        tls: :always,
        auth: :always


import_config "#{Mix.env}.exs"
