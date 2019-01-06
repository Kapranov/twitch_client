defmodule TwitchClient.APITest do
  use ExUnit.Case, async: false

  alias TwitchClient.API
  alias TwitchClient.Manager

  @login1 "josevalim"
  @login2 "lugatex"

  setup do
    start_supervised Manager
    %{}
  end

  describe "#users" do
    test "find user by its login" do
      {:ok, users} = API.users(login: [@login1])

      assert contains?(users, @login1)
    end

    test "find users by their logins" do
      {:ok, users} = API.users(login: [@login1, @login2])

      assert contains?(users, @login1)
      assert contains?(users, @login2)
    end
  end

  defp contains?(users, login) do
    users
    |> Enum.find(& (&1["login"] == login))
  end
end
