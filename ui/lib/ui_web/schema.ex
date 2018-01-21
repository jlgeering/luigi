defmodule UiWeb.Schema do
  use Absinthe.Schema

  alias UiWeb.HueResolver

  object :hue_bridge do
    field :ip, non_null(:string)
  end

  query do
    field :all_hue_bridges, non_null(list_of(non_null(:hue_bridge))) do
      resolve &HueResolver.all_hue_bridges/3
    end
  end

end
