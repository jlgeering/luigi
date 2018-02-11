defmodule Temperature do
  use Instream.Series

  series do
    measurement "temperature"

    # tag :bar
    # tag :foo

    field :value, default: nil
  end
end
