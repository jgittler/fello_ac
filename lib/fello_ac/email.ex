defmodule FelloAc.Email do
  import Swoosh.Email

  def report(%{"email" => _email, "item" => _item, "device" => _device} = body) do
    new()
    |> to("jason@felloeyewear.com")
    |> cc("jonathan@felloeyewear.com")
    |> from({"Fello Checkouts", "contact@felloeyewear.com"})
    |> subject("New Checkout Started")
    |> text_body(to_formatted_string(body))
  end

  defp to_formatted_string(map) do
    map
    |> Map.put(:initiated_at, local_now())
    |> Enum.map_join(" | ", &format_pair/1)
  end

  defp local_now do
    Application.get_env(:fello_ac, :tz)
    |> FriendlyDateTime.local_now(:long_with_tz)
  end

  defp format_pair({key, value}) do
    "#{key}: #{value}"
  end
end
