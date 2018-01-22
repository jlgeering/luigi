defmodule Net.Mixfile do
  use Mix.Project

  def project do
    [
      app: :net,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mdns, "~> 0.1.6"},
      {:nerves_ssdp_client, "~> 0.1.0"},
      {:system_registry, "~> 0.6.0"},
    ]
  end
end
