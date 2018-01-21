defmodule Hue.Bridges do

  use Agent

  def start_link(_) do
    {:ok, pid} = Agent.start_link(fn -> [] end, name: __MODULE__)
    Agent.cast(__MODULE__, fn _state -> discover() end)
    {:ok, pid}
  end

  def get() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  defp discover() do
    for bridge <- Net.SSDP.discover(:hue_bridges) do
      %{
        ip: bridge,
        with_config: false,
      }
    end
  end

end
