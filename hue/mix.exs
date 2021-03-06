defmodule Hue.Mixfile do
  use Mix.Project

  def project do
    [
      app: :hue,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Hue.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:huex, "~> 0.8"},
      {:net, path: "../net"},
    ]
  end
end
