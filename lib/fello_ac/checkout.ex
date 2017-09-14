defmodule FelloAc.Checkout do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:email, :item, :device, :inserted_at]}

  schema "checkouts" do
    field :email, :string
    field :device, :string
    field :item, :string

    timestamps()
  end

  @optional_fields ~w(email device item)

  def changeset(checkout, params \\ :empty) do
    checkout
    |> cast(params, @optional_fields, @optional_fields)
  end
end
