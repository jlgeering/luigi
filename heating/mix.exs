defmodule Heating.MixProject do
  use Mix.Project

  def project do
    [
      app: :heating,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :instream],
      mod: {Heating.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:distillery, "~> 1.5", runtime: false},
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:instream, "~> 0.17"},
    ]
  end
end
