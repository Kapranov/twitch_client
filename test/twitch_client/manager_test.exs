defmodule TwitchClient.ManagerTest do
  use ExUnit.Case, async: true

  alias TwitchClient.Manager

  setup do
    start_supervised Manager

    %{}
  end

  test "should return the token" do
    {:ok, token} = Manager.token()

    assert String.length(token) == 30
  end
end
