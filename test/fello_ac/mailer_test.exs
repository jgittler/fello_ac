defmodule FellAc.MailerTest do
  use ExUnit.Case, async: true
  doctest FelloAc.Mailer
  import Swoosh.TestAssertions

  test "sends an email" do
    body = %{"email" => "", "item" => "", "device" => ""}

    FelloAc.Email.report(body)
    |> FelloAc.Mailer.deliver

    assert_email_sent [subject: "New Checkout Started"]
  end
end
