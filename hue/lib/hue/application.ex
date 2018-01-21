defmodule Hue.Application do

  use Application

  def start(_type, _args) do

    children = [
      # Starts a worker by calling: Hue.Worker.start_link(arg)
      # {Hue.Worker, arg},
      Hue.Bridges,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hue.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
