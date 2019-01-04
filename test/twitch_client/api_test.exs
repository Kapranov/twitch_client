defmodule TwitchClient.APITest do
  use ExUnit.Case, async: true

  alias TwitchClient.API
  alias TwitchClient.Manager

  #@user_id "273547308"
  @user_name "josevalim"

  setup do
    start_supervised Manager

    %{}
  end

  describe "#users" do
    test "find user by its login" do
      {:ok, users} = API.users(login: [@user_name])

      assert contains?(users, @user_name)
    end
  end

  defp contains?(users, login) do
    users
    |> Enum.find(& (&1["login"] == login))
  end
end
