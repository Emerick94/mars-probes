defmodule MarsProbes.DirectionHelperTest do
  use ExUnit.Case
  doctest MarsProbes.DirectionHelper

  test "get direction from integer in range 0..3" do
    direction = MarsProbes.DirectionHelper.direction_name(0)
    assert direction == "N"
  end

  test "get direction from float with decimal part, rouding down as needed" do
    direction = MarsProbes.DirectionHelper.direction_name(0.2)
    assert direction == "N"
  end

  test "get direction from float with decimal part, rouding up as needed" do
    direction = MarsProbes.DirectionHelper.direction_name(0.8)
    assert direction == "E"
  end

  test "get direction from character lower case" do
    direction = MarsProbes.DirectionHelper.direction_name("e")
    assert direction == "E"
  end

  test "get direction from character upper case" do
    direction = MarsProbes.DirectionHelper.direction_name("S")
    assert direction == "S"
  end

  test "get direction from string regardeless of case" do
    direction = MarsProbes.DirectionHelper.direction_name("WeSt")
    assert direction == "W"
  end

  test "retur error geting direction from invalid string" do
    direction = MarsProbes.DirectionHelper.direction_name("westeros")
    assert direction == {:error, "no direction related to this string"}
  end

  test "retur error geting direction from invalid string that is a substring of a valid one" do
    direction = MarsProbes.DirectionHelper.direction_name("no")
    assert direction == {:error, "no direction related to this string"}
  end
end
