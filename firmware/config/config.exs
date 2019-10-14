use Mix.Config

config :luigi, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

# config :nerves_network,
#   regulatory_domain: "CH"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

# config :ui, UiWeb.Endpoint,
#   http: [port: 80],
#   url: [host: "localhost", port: 80],
#   secret_key_base: "jq5jSaw6sgQCErGhF3iQS6KXEeD9XDfVszBIslTU5mVG7sytHwXtSRqbrrR4KNP/",
#   root: Path.dirname(__DIR__),
#   server: true,
#   render_errors: [accepts: ~w(html json)],
#   code_reloader: false

if Mix.target() != :host do
  import_config "target.exs"
end
