defmodule MarsProbes.PlateauMapperTest do
  use ExUnit.Case
  alias MarsProbes.PlateauMapper
  doctest PlateauMapper

  setup do
    plateau = PlateauMapper.start_plateau(5, 6)
    %{plateau: plateau}
  end

  test "stores plateau initial state" do
    plateau = PlateauMapper.start_plateau(4, 7)

    assert plateau == %{
             size: %{x: 4, y: 7},
             probes: []
           }
  end

  test "deploy probe", %{plateau: plateau} do
    plateau = PlateauMapper.add_probe(plateau, 1, 2, "N")
    assert plateau.probes == [%{x: 1, y: 2, direction: 0}]
  end
end
