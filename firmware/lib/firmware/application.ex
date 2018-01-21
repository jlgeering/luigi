defmodule Firmware.Application do
  use Application

  @interface Application.get_env(:firmware, :interface, :eth0)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Task, [fn -> start_network() end], restart: :transient),
    ]

    opts = [strategy: :one_for_one, name: Firmware.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_network do
    Nerves.Network.setup to_string(@interface)
  end

end
