defmodule RpgSimulationTest do
  use ExUnit.Case
  doctest RpgSimulation

  test "greets the world" do
    assert RpgSimulation.hello() == :world
  end
end
