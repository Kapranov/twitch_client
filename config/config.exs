use Mix.Config

config :tesla, adapter: Tesla.Adapter.Hackney

if Mix.env == :dev && File.exists?("config/dev.secret.exs")do
  import_config "dev.secret.exs"
else
  # import_config "dev.secret.template.exs"
end

if Mix.env == :test && File.exists?("config/test.secret.exs") do
  import_config "test.secret.exs"
else
  # import_config "test.secret.template.exs"
end
