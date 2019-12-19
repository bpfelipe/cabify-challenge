defmodule CarPooling.Mixfile do
  use Mix.Project

  def project do
    [
      app: :carpooling,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {CarPooling.Application, []},
      extra_applications: [:logger, :runtime_tools, :eventstore]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:commanded, "~> 0.19"},
      {:commanded_ecto_projections, "~> 0.8"},
      {:commanded_eventstore_adapter, "~> 0.6"},
      {:cowboy, "~> 1.0"},
      {:ecto_sql, "~> 3.1"},
      {:elixir_uuid, "~> 1.2"},
      {:eventstore, "~> 0.17"},
      {:exconstructor, "~> 1.1"},
      {:ex_machina, "~> 2.1", only: :test},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.1"},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:phoenix, "~> 1.4"},
      {:phoenix_ecto, "~> 4.0"},
      {:plug_cowboy, "~> 1.0"},
      {:postgrex, ">= 0.0.0"},
      {:vex, "~> 0.6"}
    ]
  end

  defp aliases do
    [
      "event_store.init": ["event_store.drop", "event_store.create", "event_store.init"],
      "ecto.init": ["ecto.drop", "ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      reset: ["event_store.init", "ecto.init"],
      test: ["reset", "test"]
    ]
  end
end
