defmodule FelloAc do
  @moduledoc """
  Documentation for FelloAc.
  """

  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    children = [
      worker(FelloAc.Endpoint, []),
      supervisor(FelloAc.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
