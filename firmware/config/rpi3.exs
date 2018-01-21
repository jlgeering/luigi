use Mix.Config

config :firmware, interface: :eth0

config :nerves_network, :default,
  eth0: [
    ipv4_address_method: :dhcp
  ]
