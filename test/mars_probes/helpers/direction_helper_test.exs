defmodule MarsProbes.DirectionHelperTest do
  use ExUnit.Case
  doctest MarsProbes.DirectionHelper

  test "get direction from integer" do
    direction = MarsProbes.DirectionHelper.direction(0)
    assert direction == "N"
  end

  test "get direction from float with decimal part, rouding down as needed" do
    direction = MarsProbes.DirectionHelper.direction(0.2)
    assert direction == "N"
  end

  test "get direction from float with decimal part, rouding up as needed" do
    direction = MarsProbes.DirectionHelper.direction(0.8)
    assert direction == "E"
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

  test "retur error geting direction from invalid string" do
    direction = MarsProbes.DirectionHelper.direction("westeros")
    assert direction == {:error, "no direction related to this string"}
  end

  test "retur error geting direction from invalid string who is a substring of a valid one" do
    direction = MarsProbes.DirectionHelper.direction("no")
    assert direction == {:error, "no direction related to this string"}
  end
end
