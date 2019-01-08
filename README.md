# TwitchClient

A client implementation for the Twitch API

**TODO: Add description**

```bash
bash> mkdir twitch_client
bash> cd twitch_client
bash> mix new ./ --sup --app twitch_client
```
Start and testing application:

```bash
bash> make packs
bash> make all
```
Git push, pull and log:

```bash
bash> make log
bash> make pull
bash> make git-"your_commit"
```
Logging application:

```bash
iex> :observer.start
```

```bash
bash> curl  -H 'Authorization: Bearer 0xmz427552cqp246if9tngk3hikms8' \
            -X GET 'https://api.twitch.tv/helix/users?id=273547308' | jq .

bash> curl  -H 'Authorization: Bearer 0xmz427552cqp246if9tngk3hikms8' \
            -X GET 'https://api.twitch.tv/helix/users?login=josevalim' | jq .

bash> curl  -H 'Client-ID: vidi3jyx3xs9a0ouis2w3ullvfse9vp' \
            -X GET 'https://api.twitch.tv/helix/streams?first=20' | jq .

bash> curl  -H 'Client-ID: vidi3jyx3xs9a0ous2w3ullvfse9vp' \
            -X GET 'https://api.twitch.tv/helix/streams/metadata' | jq .

bash> curl  -H 'Client-ID: vidi3jyx3xs9a0ous2w3ullvfse9vp' \
            -X GET 'https://api.twitch.tv/helix/users?id=273547308' | jq .

bash> curl  -H 'Client-ID: vidi3jyx3xs9a0ous2w3ullvfse9vp' \
            -X GET 'https://api.twitch.tv/helix/users?login=josevalim' | jq .
```

**NOTE:** If you change the `TWITCH_CLIENT_ID` and the `TWITCH_SECRET` remember to run a `mix clean`

## Setup

Create a [Twitch app](https://dev.twitch.tv/dashboard/apps/create), and
then export the `clientId` and the `secret` as environment variables:

```bash
export TWITCH_CLIENT_ID=<YOUR_CLIENT_ID>
export TWITCH_SECRET=<YOUR_SECRET>
```

## Example Usage

An example of querying the
[`/users`](https://dev.twitch.tv/docs/api/reference/#get-users) endpoint

```bash
iex> Application.get_env(:twitch_client, :twitch_secret)
iex> Application.get_env(:twitch_client, :twitch_client_id)
```

If disable Supervisor in `mix.ex` - `mod: {TwitchClient.Application, []}`,
and in file `lib/twitch_client/application.ex`:

```elixir
defmodule TwitchClient.Application do
  @moduledoc false

  use Application

  alias TwitchClient.Manager

  def start(_type, _args) do
    children = [
    ]

    opts = [strategy: :one_for_one, name: TwitchClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```
Then run the command in console:

```bash
iex> TwitchClient.Manager.start_link(%{})
#=> {:ok, #PID<0.178.0>}
```
and others commands:

```bash
iex> {:ok, users} = TwitchClient.API.users(login: ["josevalim"])
#=> {:ok,
      [
        %{
          "broadcaster_type" => "",
          "description" => "@plataformatec co-founder & creator of @elixirlang",
          "display_name" => "josevalim",
          "id" => "273547308",
          "login" => "josevalim",
          "offline_image_url" => "",
          "profile_image_url" => "https://static-cdn.jtvnw.net/jtv_user_pictures/128192c8-53bf-4f0f-815d-cff9a23f8d74-profile_image-300x300.jpg",
          "type" => "",
          "view_count" => 11311
        }
      ]
    }

iex> TwitchClient.Token.create
#=> #=> %{expires_in: 5320374000, token: "pylwgejgrxhykwbniou8h8eo81m6oz"}
```

### 30 Dec 2018 by Oleg G.Kapranov

[1]: https://dev.twitch.tv/docs/v5/
[2]: https://dev.twitch.tv/docs/api/reference/#get-users
[3]: https://dev.twitch.tv/docs/api/reference/#get-videos
