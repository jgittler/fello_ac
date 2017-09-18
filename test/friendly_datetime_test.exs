defmodule FriendlyDateTimeTest do
  use ExUnit.Case, async: true
  doctest FriendlyDateTime

  @time_zone "America/Los_Angeles"

  test "format long_with_tz local_now" do
    assert {_, _, _, _, _, _} = FriendlyDateTime.local_now(@time_zone, :long_with_tz) |> datetime_parts
  end

  test "format long_without_tz local_now" do
    assert {_, _, _, _, _} = FriendlyDateTime.local_now(@time_zone, :long_without_tz) |> datetime_parts
  end

  test "local_now with unsupported format" do
    assert {:error, "unsupported format"} = FriendlyDateTime.local_now(@time_zone, :bad_format)
  end

  test "local from string" do
    datetime_string = "2017-09-17T06:12:56.957216"
    assert {_, _, _, _, _, _} = FriendlyDateTime.local(datetime_string, :long_with_tz) |> datetime_parts
  end

  test "local from non-datetime string" do
    non_datetime_string = "not a date time"
    assert FriendlyDateTime.local(non_datetime_string, :long_with_tz) == non_datetime_string
  end

  test "local from DateTime" do
    datetime = DateTime.utc_now
    assert {_, _, _, _, _, _} = FriendlyDateTime.local(datetime, :long_with_tz) |> datetime_parts
  end

  test "local from NaiveDateTime" do
    naive_datetime = NaiveDateTime.utc_now
    assert {_, _, _, _, _, _} = FriendlyDateTime.local(naive_datetime, :long_with_tz) |> datetime_parts
  end

  test "local with unsupported date type" do
    assert {:error, "unsupported date type"} = FriendlyDateTime.local({2011, 11, 11}, :long_with_tz)
  end

  test "local with unsupported format" do
    datetime = DateTime.utc_now
    assert {:error, "unsupported format"} = FriendlyDateTime.local(datetime, :bad_format)
  end

  defp datetime_parts(datetime_string) do
    datetime_string
    |> String.split(" ")
    |> List.to_tuple
  end
end
