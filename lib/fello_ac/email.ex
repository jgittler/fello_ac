defmodule FelloAc.Email do
  import Swoosh.Email

  def welcome_email(%{"email" => _email, "item" => _item, "device" => _device} = body) do
    new()
    |> to("jason@felloeyewear.com")
    |> cc("jonathan@felloeyewear.com")
    |> from({"Fello Checkouts", "contact@felloeyewear.com"})
    |> subject("New Checkout Started")
    |> text_body(to_formatted_string(body))
  end

  defp to_formatted_string(map) do
    map
    |> Enum.map_join(" | ", fn({key, value}) -> "#{key}: #{value}" end)
  end
end
