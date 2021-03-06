defmodule TwitchClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :twitch_client,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.json": :test
      ],
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: applications(Mix.env),
      mod: {TwitchClient.Application, []}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10.3", only: :test},
      {:ex_doc, "~> 0.19.2", only: :dev},
      {:ex_unit_notifier, "~> 0.1.4", only: :test},
      {:hackney, "~> 1.14.0"},
      {:jason, "~> 1.1.2"},
      {:tesla, "~> 1.2.1"},
      {:poison, "~> 4.0.1"},
      {:mix_test_watch, "~> 0.9.0", only: :dev, runtime: false},
      {:mock, "~> 0.3.2", only: :test},
      {:remix, "~> 0.0.2", only: :dev},
      {:elixir_uuid, "~> 1.2", only: :test}
    ]
  end

  defp applications(:dev), do: applications(:all) ++ [:remix]
  defp applications(_all), do: [:logger]

  defp docs do
    [
      name: "TwitchClient",
      main: "TwitchClient",
      homepage_url: "http://localhost",
      source_url: "https://github.com/kapranov/twitch_client",
      extras: ["README.md"]
    ]
  end
end
