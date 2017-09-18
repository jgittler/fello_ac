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

  defimpl Poison.Encoder, for: __MODULE__ do
    def encode(
      %{
        email: email,
        item: item,
        device: device,
        inserted_at: inserted_at
      },
      options
    ) do

      datetime_formatter = case Keyword.get(options, :datetime_formatter) do
        {:ok, func} -> func

        _ -> &FriendlyDateTime.local/2
      end

      Poison.Encoder.encode(%{
        email: email,
        item: item,
        device: device,
        initiated_at: datetime_formatter.(inserted_at, :long_with_tz)
      }, [])
    end
  end
end
