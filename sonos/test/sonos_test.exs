defmodule SonosTest do
  use ExUnit.Case
  doctest Sonos

  test "greets the world" do
    assert Sonos.hello() == :world
  end
end
