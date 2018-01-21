# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Customize the firmware. Uncomment all or parts of the following
# to add files to the root filesystem or modify the firmware
# archive.

# config :nerves, :firmware,
#   rootfs_overlay: "rootfs_overlay",
#   fwup_conf: "config/fwup.conf"

# Use bootloader to start the main application. See the bootloader
# docs for separating out critical OTP applications such as those
# involved with firmware updates.
config :bootloader,
  init: [:nerves_runtime, :nerves_network],
  app: Mix.Project.config()[:app]

config :nerves_network,
  regulatory_domain: "CH"

# config :firmware, interface: :eth0
# config :firmware, interface: :wlan0
# config :firmware, interface: :usb0

config :ui, UiWeb.Endpoint,
  http: [port: 80],
  url: [host: "localhost", port: 80],
  secret_key_base: "jq5jSaw6sgQCErGhF3iQS6KXEeD9XDfVszBIslTU5mVG7sytHwXtSRqbrrR4KNP/",
  root: Path.dirname(__DIR__),
  server: true,
  render_errors: [accepts: ~w(html json)],
  code_reloader: false

config :logger, :logger_papertrail_backend,
  url: System.get_env("PAPERTRAIL_URL"),
  level: :debug,
  format: "$metadata $message"

config :logger,
  backends: [ :console, LoggerPapertrailBackend.Logger ],
  level: :debug

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

import_config "#{Mix.Project.config[:target]}.exs"
