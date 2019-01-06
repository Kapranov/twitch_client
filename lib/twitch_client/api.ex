defmodule TwitchClient.API do
  @moduledoc false

  use Tesla

  alias TwitchClient.Manager

  plug Tesla.Middleware.BaseUrl, "https://api.twitch.tv/helix"
  plug Tesla.Middleware.JSON

  def users(opts) do
    login_tuples =
      opts
      |> Keyword.get(:login)
      |> to_tuples("login")

    id_tuples =
      opts
      |> Keyword.get(:id)
      |> to_tuples("id")

    data =
      read_token()
      |> build_client
      |> get("/users?" <> to_query_parameters(login_tuples ++ id_tuples))
      |> data

    {:ok, data}
  end

  defp read_token do
    {:ok, token} = Manager.token()
    token
  end

  defp build_client(token) do
    Tesla.client [
      {Tesla.Middleware.Headers, [{"Authorization", "Bearer " <> token}]}
    ]
  end

  defp data({:ok, %Tesla.Env{body: %{"data" => data}}}), do: data

  defp to_tuples(nil, _tuple_key), do: []
  defp to_tuples(list, tuple_key), do: Enum.map(list, & {tuple_key, &1})

  defp to_query_parameters(list) do
    list
    |> Enum.map(fn({key, value}) -> key <> "=" <> value end)
    |> Enum.join("&")
  end
end
