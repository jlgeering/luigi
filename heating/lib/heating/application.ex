defmodule Heating.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Heating.Worker.start_link(arg)
      # {Heating.Worker, arg},
      Heating.Connection,
      Supervisor.child_spec({Heating.Tracker, ["http://192.168.0.52/temperature", %Temperature{}, :temperature]}, id: :temperature_tracker),
      Supervisor.child_spec({Heating.Tracker, ["http://192.168.0.52/detector/latest", %HeatingState{}, :latest]}, id: :heating_tracker)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Heating.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
