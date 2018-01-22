use Mix.Config

config :firmware, interface: :eth0
config :net, bonjour: "luigi-rpi3.local"

config :nerves_network, :default,
  eth0: [
    ipv4_address_method: :dhcp
  ]
