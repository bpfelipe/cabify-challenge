# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

Code.require_file("env_config.ex", __DIR__)
# General application configuration
config :carpooling,
  namespace: CarPooling,
  ecto_repos: [CarPooling.Repo]

# Configures the endpoint
config :carpooling, CarPoolingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XW4+FrHe/8jTaYamLmNA9dVT5ig88k/DE6DkKOha1MhCrVxfBui5isp1VUAsPhPg",
  render_errors: [view: CarPoolingWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CarPooling.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Config Vex Validator

config :vex,
  sources: [
    CarPooling.Support.Validators,
    CarPooling.Runs.Validators,
    Vex.Validators
  ]

config :phoenix, :json_library, Jason

config :commanded_ecto_projections,
  repo: CarPooling.Repo

# Configures commanded event store adapter
config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

# Configure commanded event store database
config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: Env.Config.get_str("db_event_store_username", "postgres"),
  password: Env.Config.get_str("db_event_store_password", "postgres"),
  database: Env.Config.get_str("db_event_store_database", "event_store_db"),
  hostname: Env.Config.get_str("db_event_store_hostname", "localhost"),
  pool_size: Env.Config.get_int("db_event_store_poolsize", 4)

# Configure Application database
config :carpooling, CarPooling.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: Env.Config.get_str("db_read_store_username", "postgres"),
  password: Env.Config.get_str("db_read_store_password", "postgres"),
  database: Env.Config.get_str("db_read_store_database", "read_store_db"),
  hostname: Env.Config.get_str("db_read_store_hostname", "localhost"),
  pool_size: Env.Config.get_int("db_read_store_poolsize", 4)

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
