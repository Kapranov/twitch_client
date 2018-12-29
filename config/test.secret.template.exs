use Mix.Config

config :ex_unit_notifier,
  notifier: ExUnitNotifier.Notifiers.NotifySend
config :twitch_client, twitch_client_id: "<YOUR_CLIENT_ID>", twitch_secret: "<YOUR_SECRET>"
