defmodule TwitchClient.Manager do
  @moduledoc false

  use GenServer

  @name __MODULE__
  @manager :twitch_client_manager

  def start_link(_opts), do: GenServer.start_link(@name, [], name: @manager)

  def init(_args) do
    {:ok, nil}
  end

  def token do
    GenServer.call(@manager, :token)
  end

  def handle_call(:token, _from, token) do
    {:reply, {:ok, token}, token}
  end
end
