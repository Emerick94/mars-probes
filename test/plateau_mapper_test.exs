defmodule MarsProbes.PlateauMapperTest do
  use ExUnit.Case
  doctest MarsProbes

  setup do
    {:ok, plateau} = MarsProbes.PlateauMapper.start_link(5, 6)
    %{plateau: plateau}
  end

  test "stores plateau size" do
    {:ok, plateau} = MarsProbes.PlateauMapper.start_link(4, 7)
    assert MarsProbes.PlateauMapper.get(plateau, :size) == %{x: 4, y: 7}
  end

  test "deploy probe", %{plateau: plateau} do
    MarsProbes.PlateauMapper.add_probe(1, 2, "N")
    assert MarsProbes.PlateauMapper.get(plateau, :probes) == [%{x: 1, y: 2, direction: "N"}]
  end
end
