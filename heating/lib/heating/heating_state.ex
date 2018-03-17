defmodule HeatingState do
  use Instream.Series

  series do
    measurement "heating"

    # tag :bar
    # tag :foo

    field :value, default: nil
  end
end
