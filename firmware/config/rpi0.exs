use Mix.Config

config :firmware, interface: :wlan0
config :net, bonjour: "luigi-rpi0.local"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: :"WPA-PSK"
  ]