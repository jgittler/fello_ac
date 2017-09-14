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

    conn = conn(:get, "/list?secret=secret")
           |> FelloAc.Endpoint.call(@_opts)

    assert conn.state == :sent
    assert conn.status == 200

    resp_body = conn.resp_body |> Poison.decode! |> List.first

    assert resp_body |> Map.fetch!("item") == "test-item"
    assert resp_body |> Map.fetch!("device") == "test-device"
    assert resp_body |> Map.fetch!("email") == "test@example.com"
    assert {:ok, _datetime} = resp_body |> extract_datetime
  end

  test "POST /create" do
    body = %{
      "email" => "test@example.com",
      "item" => "test-item",
      "device" => "test-device"
    }

    conn = conn(:post, "/create", body) |> FelloAc.Endpoint.call(@_opts)

    assert conn.state == :sent
    assert conn.status == 201

    resp_body = conn.resp_body |> Poison.decode!

    assert resp_body |> Map.fetch!("id") |> is_integer
  end

  def extract_datetime(%{"inserted_at" => date_string}) do
    {:ok, ndt} = date_string |> NaiveDateTime.from_iso8601
    DateTime.from_naive(ndt, "Etc/UTC")
  end
end
