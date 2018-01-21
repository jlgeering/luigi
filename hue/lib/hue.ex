defmodule Hue do

  def all_bridges() do
    for bridge <- Net.SSDP.discover(:hue_bridges) do
      # TODO add configured: bool
      %{ip: bridge}
    end
  end

end
