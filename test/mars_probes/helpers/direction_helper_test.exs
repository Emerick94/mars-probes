defmodule MarsProbes.DirectionHelperTest do
  use ExUnit.Case
  doctest MarsProbes.DirectionHelper

  # get_direction
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

  test "get direction from atom regardeless of case" do
    direction = MarsProbes.DirectionHelper.direction_name(:nOrTh)
    assert direction == "N"
  end

  test "retur error geting direction from invalid string" do
    direction = MarsProbes.DirectionHelper.direction_name("westeros")
    assert direction == {:error, "no direction related to this string."}
  end

  test "retur error geting direction from invalid string that is a substring of a valid one" do
    direction = MarsProbes.DirectionHelper.direction_name("no")
    assert direction == {:error, "no direction related to this string."}
  end

  test "retur error geting direction from invalid variable type" do
    direction = MarsProbes.DirectionHelper.direction_name(%{direction: "north"})

    assert direction ==
             {:error, "this argument is invalid, please use integer, float, string or atom."}
  end

  # to_number
  # The tests are the same as the above, to ensure constency between the fucntions
  test "get direction number from integer in range 0..3" do
    direction = MarsProbes.DirectionHelper.direction_number(0)
    assert direction == 0
  end

  test "get direction number from float with decimal part, rouding down as needed" do
    direction = MarsProbes.DirectionHelper.direction_number(0.2)
    assert direction == 0
  end

  test "get direction number from float with decimal part, rouding up as needed" do
    direction = MarsProbes.DirectionHelper.direction_number(0.8)
    assert direction == 1
  end

  test "get direction number from character lower case" do
    direction = MarsProbes.DirectionHelper.direction_number("e")
    assert direction == 1
  end

  test "get direction number from character upper case" do
    direction = MarsProbes.DirectionHelper.direction_number("S")
    assert direction == 2
  end

  test "get direction number from string regardeless of case" do
    direction = MarsProbes.DirectionHelper.direction_number("WeSt")
    assert direction == 3
  end

  test "get direction number from atom regardeless of case" do
    direction = MarsProbes.DirectionHelper.direction_number(:nOrTh)
    assert direction == 0
  end

  test "retur error geting direction number from invalid string" do
    direction = MarsProbes.DirectionHelper.direction_number("westeros")
    assert direction == {:error, "no direction related to this string."}
  end

  test "retur error geting direction number from invalid string that is a substring of a valid one" do
    direction = MarsProbes.DirectionHelper.direction_number("no")
    assert direction == {:error, "no direction related to this string."}
  end

  test "retur error geting direction number from invalid variable type" do
    direction = MarsProbes.DirectionHelper.direction_number(%{direction: "north"})

    assert direction ==
             {:error, "this argument is invalid, please use integer, float, string or atom."}
  end
end
