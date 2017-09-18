defmodule FelloAc.EmailTest do
  use ExUnit.Case, async: true
  doctest FelloAc.Email

  test "creates email with checkout data" do
    email = "test@test.com"
    item = "test-item"
    device = "test-device"
    body = %{"email" => email, "item" => item, "device" => device}

    assert %Swoosh.Email{text_body: text_body} = FelloAc.Email.report(body)

    rest = " | device: #{device} | email: #{email} | item: #{item}"

    assert "initiated_at: " <> <<number::bytes-size(31)>> <> rest = text_body
  end
end
