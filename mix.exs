defmodule FelloAc.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fello_ac,
      version: "0.1.0",
      elixir: "~> 1.4.2",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {FelloAc, []},
      extra_applications: [:logger, :timex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.1"},
      {:plug, "~> 1.4"},
      {:poison, "~> 3.1"},
      {:ecto, "~> 2.2"},
      {:postgrex, "~> 0.13.3"},
      {:eiconv, github: "zotonic/eiconv"},
      {:swoosh, "~> 0.10.0"},
      {:gen_smtp, "~> 0.12.0"},
      {:timex, "~> 3.1"}
    ]
  end
end
