defmodule MarsProbes.PlateauMapperTest do
  use ExUnit.Case

  alias MarsProbes.PlateauMapper
  doctest PlateauMapper

  setup do
    plateau = PlateauMapper.start_plateau(5, 6)
    plateau = PlateauMapper.add_probe(plateau, 1, 2, "N")

    %{plateau: plateau}
  end

  # start_plateau
  test "stores plateau initial state" do
    plateau = PlateauMapper.start_plateau(4, 7)

    assert plateau == %{
             size: %{x: 4, y: 7},
             probes: []
           }
  end

  test "stores plateau with user input" do
    plateau = PlateauMapper.start_plateau("4 7\n")

    assert plateau == %{
             size: %{x: 4, y: 7},
             probes: []
           }
  end

  # add_probe
  test "add valid probe", %{plateau: plateau} do
    plateau = PlateauMapper.add_probe(plateau, 2, 1, "E")
    assert plateau.probes == [%{direction: 1, x: 2, y: 1}, %{direction: 0, x: 1, y: 2}]
  end

  test "add valid probe with user input", %{plateau: plateau} do
    plateau = PlateauMapper.add_probe(plateau, "2 1 e")
    assert plateau.probes == [%{direction: 1, x: 2, y: 1}, %{direction: 0, x: 1, y: 2}]
  end

  test "plateu unchanged when adding invalid probe", %{plateau: plateau} do
    plateau = PlateauMapper.add_probe(plateau, 7, 6, "N")
    assert plateau.probes == [%{direction: 0, x: 1, y: 2}]
  end

  test "add multiple valid probes", %{plateau: plateau} do
    plateau = PlateauMapper.add_probe(plateau, 2, 4, "W")
    plateau = PlateauMapper.add_probe(plateau, 4, 5, "S")

    assert plateau.probes == [
             %{direction: 2, x: 4, y: 5},
             %{direction: 3, x: 2, y: 4},
             %{direction: 0, x: 1, y: 2}
           ]
  end

  # show_probes
  test "show a probe", %{plateau: plateau} do
    assert PlateauMapper.show_probes(plateau) == ["1 2 N"]
  end

  test "show two probes", %{plateau: plateau} do
    plateau = PlateauMapper.add_probe(plateau, 3, 1, "E")
    assert PlateauMapper.show_probes(plateau) == ["1 2 N", "3 1 E"]
  end

  # single_instruction
  test "turn drone to the left", %{plateau: plateau} do
    plateau = PlateauMapper.single_instruction(plateau, "L")
    assert PlateauMapper.show_probes(plateau) == ["1 2 W"]
  end

  test "turn drone to the right", %{plateau: plateau} do
    plateau = PlateauMapper.single_instruction(plateau, "R")
    assert PlateauMapper.show_probes(plateau) == ["1 2 E"]
  end

  test "moves drone one space", %{plateau: plateau} do
    plateau = PlateauMapper.single_instruction(plateau, "M")
    assert PlateauMapper.show_probes(plateau) == ["1 3 N"]
  end

  test "invalid instruction", %{plateau: plateau} do
    plateau = PlateauMapper.single_instruction(plateau, "Z")
    assert PlateauMapper.show_probes(plateau) == ["1 2 N"]
    # assert capture_io(plateu) == "invalid instruction `Z`"
  end

  # move_probe
  test "moves last probe", %{plateau: plateau} do
    plateau = PlateauMapper.follow_instructions(plateau, "LMLMLMLMM")
    assert PlateauMapper.show_probes(plateau) == ["1 3 N"]
  end
end
