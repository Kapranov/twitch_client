defmodule TwitchClient.ManagerTest do
  use ExUnit.Case, async: true

  import Mock

  alias TwitchClient.Manager
  alias TwitchClient.Token

  setup do
    start_supervised Manager
    %{}
  end

  test "should return the token" do
    {:ok, token} = Manager.token()

    assert String.length(token) == 30
  end

  test "should renew an expired token from another module" do
    with_mock Token, [:passthrough], [create: &random_token/0] do
      {:ok, token1} = Manager.token()
      Process.sleep(3_000)

      {:ok, token2} = Manager.token()

      assert token2 != token1
    end
  end

  defp random_token do
    %{token: UUID.uuid1(:hex), expires_in: 1000}
  end
end
