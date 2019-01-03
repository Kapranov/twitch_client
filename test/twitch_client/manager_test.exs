defmodule TwitchClient.ManagerTest do
  use ExUnit.Case, async: true

  # import Mock

  # alias TwitchClient.Token
  alias TwitchClient.Manager

  setup do
    start_supervised Manager

    %{}
  end

  test "should return the token" do
    {:ok, token} = Manager.token()

    assert String.length(token) == 30
  end

  test "should renew an expired token" do
    # with_mock Token, [create: &random_token/0] do
    #   {:ok, new_token} = Manager.token()
    #   Process.sleep(2000)

    #   {:ok, renew_token} = Manager.token()

    #   assert renew_token != new_token
    # end
  end

  # defp random_token do
  #   %{token: UUID.uuid1(:hex), expires_in: 1000}
  # end
end
