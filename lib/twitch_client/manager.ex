defmodule TwitchClient.Manager do
  @moduledoc false

  alias TwitchClient.Token

  use GenServer

  @name __MODULE__
  @manager :twitch_client_manager

  def start_link(_opts), do: GenServer.start_link(@name, [], name: @manager)

  def init(_args) do
    send(self(), :retrieve_token)
    {:ok, nil}
  end

  def token do
    GenServer.call(@manager, :token)
  end

  def handle_call(:token, _from, token) do
    {:reply, {:ok, token}, token}
  end

  def handle_info(:retrieve_token, _token) do
    %{token: token, expires_in: expiration} = Token.create()
    Process.send_after(@manager, :retrieve_token, expiration)

    {:noreply, token}
  end
end
