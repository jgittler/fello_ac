defmodule FelloAc.Endpoint do
  use Plug.Router
  alias FelloAc.Checkout

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  def init(_opts) do
  end

  def start_link do
    port = Application.fetch_env!(:fello_ac, :port)
    {:ok, _} = Plug.Adapters.Cowboy.http(__MODULE__, [], port: port)
  end

  get "/list" do
    {status, body} =
      case conn.query_params do
        %{"secret" => secret} -> maybe_return_list(secret)

        _ -> unauthorized_response()
      end

    send_resp(conn, status, body)
  end

  post "/create" do
    {status, body} =
      case conn.body_params do
        %{"item" => _item, "device" => _device, "email" => _email} ->
          body = conn.body_params

          Checkouts.report_async(body)

          {:ok, checkout} = Checkouts.create(body)

          {201, create_respons_body(checkout)}

        _ -> bad_request_response()
      end

    send_resp(conn, status, body)
  end

  defp create_respons_body(%Checkout{id: id}) do
    Poison.encode!(%{id: id})
  end

  defp maybe_return_list(secret) do
    expected_secret = Application.get_env(:fello_ac, :secret)
    cond do
      expected_secret == secret -> {200, list_body()}
      true -> unauthorized_response()
    end
  end

  defp list_body do
    Checkouts.list_data
    |> Poison.encode!
  end

  defp empty_response_body do
    Poison.encode!(%{})
  end

  defp unauthorized_response do
    {401, empty_response_body()}
  end

  defp bad_request_response do
    {400, empty_response_body()}
  end
end
