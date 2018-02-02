defmodule HeatingTest do
  use ExUnit.Case
  doctest Heating

  test "greets the world" do
    assert Heating.hello() == :world
  end
end
