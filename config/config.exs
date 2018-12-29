use Mix.Config

if Mix.env == :dev && File.exists?("config/dev.secret.exs")do
  config :mix_test_watch, clear: true
  import_config "dev.secret.exs"
else
  import_config "dev.secret.template.exs"
end

if Mix.env == :test && File.exists?("config/test.secret.exs") do
  config :ex_unit_notifier, notifier: ExUnitNotifier.Notifiers.NotifySend
  import_config "test.secret.exs"
else
  import_config "test.secret.template.exs"
end
