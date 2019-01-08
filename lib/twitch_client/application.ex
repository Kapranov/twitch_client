defmodule TwitchClient.Application do
  @moduledoc false

  use Application

  alias TwitchClient.Manager

  def start(_type, _args) do
    children = [
      Manager
    ]

    opts = [strategy: :one_for_one, name: TwitchClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
