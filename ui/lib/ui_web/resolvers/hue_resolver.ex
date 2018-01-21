defmodule UiWeb.HueResolver do

  def all_hue_bridges(_root, _args, _info) do
    bridges = Hue.Bridges.get()
    {:ok, bridges}
  end

end
