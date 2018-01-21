defmodule Hue do

  def all_bridges() do
    for bridge <- Net.SSDP.discover(:hue_bridges) do
      %{
        ip: bridge,
        with_config: false,
      }
    end
  end

end
