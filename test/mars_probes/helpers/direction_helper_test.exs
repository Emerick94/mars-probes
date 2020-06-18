defmodule MarsProbes.DirectionHelperTest do
  use ExUnit.Case
  doctest MarsProbes.DirectionHelper

  test "get direction from integer" do
    direction = MarsProbes.DirectionHelper.direction(0)
    assert direction == "N"
  end

  test "get direction from character lower case" do
    direction = MarsProbes.DirectionHelper.direction("e")
    assert direction == "E"
  end

  test "get direction from character upper case" do
    direction = MarsProbes.DirectionHelper.direction("S")
    assert direction == "S"
  end

  test "get direction from string regardeless of case" do
    direction = MarsProbes.DirectionHelper.direction("WeSt")
    assert direction == "W"
  end
end
