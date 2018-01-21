defmodule UiWeb.HueResolver do

  def all_hue_bridges(_root, _args, _info) do
    bridges = Hue.all_bridges()
    {:ok, bridges}
  end

end
