defmodule TwitchClientTest do
  use ExUnit.Case
  doctest TwitchClient

  test "greets the world" do
    assert TwitchClient.hello() == :world
  end
end
