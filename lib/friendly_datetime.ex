defmodule FriendlyDateTime do
  defmodule Formatter do
    def call(%DateTime{} = datetime, :long_with_tz) do
      Timex.format!(datetime, "{RFC1123}")
    end

    def call(%DateTime{} = datetime, :long_without_tz) do
      Timex.format!(datetime, "{ANSIC}")
    end

    def call(%DateTime{}, _), do: {:error, "unsupported format"}
  end

  def local_now(time_zone, format) do
    now(time_zone)
    |> Formatter.call(format)
  end

  def local(datetime, format) when is_bitstring(datetime) do
    case DateTime.from_iso8601(datetime) do
      {:ok, datetime, _} -> Formatter.call(datetime, format)

      {:error, :missing_offset} ->
        NaiveDateTime.from_iso8601!(datetime)
        |> Timex.local
        |> Formatter.call(format)

      {:error, _} -> datetime
    end
  end

  def local(%DateTime{} = datetime, format) do
    Formatter.call(datetime, format)
  end

  def local(%NaiveDateTime{} = naive_datetime, format) do
    naive_datetime
    |> Timex.local
    |> Formatter.call(format)
  end

  def local(_, _), do: {:error, "unsupported date type"}

  defp now(time_zone) do
    Timex.now(time_zone)
  end
end
