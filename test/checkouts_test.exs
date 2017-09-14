defmodule CheckoutsTest do
  use ExUnit.Case, async: true
  doctest Checkouts

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FelloAc.Repo)
  end

  test "creating a Checkout" do
    data = %{
      "email" => "test@example.com",
      "device" => "test-device",
      "item" => "test-item"
    }

    assert {:ok, %FelloAc.Checkout{}} = Checkouts.create(data)
  end

  test "listing all Checkouts" do
    data = %{
      "email" => "test@example.com",
      "device" => "test-device",
      "item" => "test-item"
    }

    Checkouts.create(data)
    Checkouts.create(data)

    assert [
      {"test@example.com", "test-device", "test-item", {:ok, %DateTime{}}},
      {"test@example.com", "test-device", "test-item", {:ok, %DateTime{}}}
    ] = Checkouts.list_data |> parse_list_data
  end

  defp parse_list_data(list_data) do
    list_data
    |> Enum.map(fn c ->
      %FelloAc.Checkout{email: email, device: device, item: item, inserted_at: inserted_at} = c
      {email, device, item, DateTime.from_naive(inserted_at, "Etc/UTC")}
    end)
  end
end
