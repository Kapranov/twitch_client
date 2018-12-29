defmodule TwitchClient.Token do
  @moduledoc false

  use Tesla

  @twitch_client_id Application.get_env(:twitch_client, :twitch_client_id)
  @twitch_secret Application.get_env(:twitch_client, :twitch_secret)

  plug Tesla.Middleware.BaseUrl, "https://id.twitch.tv/oauth2"
  plug Tesla.Middleware.JSON

  def create do
    %Tesla.Env{body: %{"access_token" => token, "expires_in" => expiration_in_seconds}} = post("token?client_id=" <> @twitch_client_id <> "&client_secret=" <> @twitch_secret <> "&grant_type=client_credentials", "")
    %{token: token, expires_in: expiration_in_seconds * 1000}
  end
end
