defmodule Checkouts do
  import Ecto.Query, only: [from: 2]
  alias FelloAc.Checkout
  alias FelloAc.Repo

  def report_async(body) do
    Task.start(fn ->
      body
      |> FelloAc.Email.report
      |> FelloAc.Mailer.deliver
    end)
  end

  def create(data) do
    data
    |> create_changeset
    |> Repo.insert
  end

  def list_data do
    query = from Checkout,
      order_by: [desc: :inserted_at],
      select: [:email, :item, :device, :inserted_at]

    Repo.all(query)
  end

  defp create_changeset(changes) do
    %Checkout{}
    |> Checkout.changeset(changes)
  end
end
