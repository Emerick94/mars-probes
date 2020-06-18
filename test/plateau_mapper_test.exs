defmodule MarsProbes.PlateauMapperTest do
  use ExUnit.Case
  doctest MarsProbes

  test "stores plateau size" do
    {:ok, plateau} = MarsProbes.PlateauMapper.start_link(4, 7)
    assert MarsProbes.PlateauMapper.get(plateau, :size) == %{x: 4, y: 7}
  end
end
