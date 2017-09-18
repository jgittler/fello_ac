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
      %{email: "test@example.com", device: "test-device", item: "test-item", inserted_at: %NaiveDateTime{}},
      %{email: "test@example.com", device: "test-device", item: "test-item", inserted_at: %NaiveDateTime{}}
    ] = Checkouts.list_data
  end
end
