defmodule Firmware.Application do
  use Application

  def start(_type, _args) do
    # import Supervisor.Spec, warn: false

    children = [
      # Children for all targets

      # TODO move to :net app
      # {Net.Bonjour, []},
    ] ++ children(target())

    opts = [strategy: :one_for_one, name: Firmware.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def children(:host) do
    [
      # Children that only run on the host
    ]
  end

  def children(_target) do
    [
      # Children for all targets except :host
    ]
  end

  def target() do
    Application.get_env(:luigi, :target)
  end

end
