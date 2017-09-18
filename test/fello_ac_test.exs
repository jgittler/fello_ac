defmodule FelloAcTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest FelloAc

  @_opts FelloAc.Endpoint.init([])

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FelloAc.Repo)
  end

  test "GET /list" do
    Checkouts.create(%{
      "item" => "test-item",
      "device" => "test-device",
      "email" => "test@example.com"
    })
    Checkouts.create(%{
      "item" => "test-item",
      "device" => "test-device",
      "email" => "test2@example.com"
    })

    conn = conn(:get, "/list?secret=secret")
           |> FelloAc.Endpoint.call(@_opts)

    assert conn.state == :sent
    assert conn.status == 200

    resp_body = conn.resp_body |> Poison.decode!

    assert length(resp_body) == 2

    first_item = List.first(resp_body)

    assert first_item |> Map.fetch!("item") == "test-item"
    assert first_item |> Map.fetch!("device") == "test-device"
    assert first_item |> Map.fetch!("email") == "test2@example.com"
    assert first_item |> Map.fetch!("initiated_at") != "unsupported format"
  end

  test "POST /create" do
    query_params = "?email=test@example.com&item=test-item&device=test-device"

    conn = conn(:post, "/create#{query_params}") |> FelloAc.Endpoint.call(@_opts)

    assert conn.state == :sent
    assert conn.status == 201

    resp_body = conn.resp_body |> Poison.decode!

    assert resp_body |> Map.fetch!("id") |> is_integer
  end
end
