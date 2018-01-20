defmodule NetTest do
  use ExUnit.Case
  doctest Net

  test "greets the world" do
    assert Net.hello() == :world
  end
end
