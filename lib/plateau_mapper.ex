defmodule MarsProbes.PlateauMapper do
  use Agent

  @doc """
  Starts a new plateau.
  """
  def start_link(x, y) do
    Agent.start_link(fn ->
      %{
        size: %{x: x, y: y}
      }
    end)
  end

  def get(plateau, key) do
    Agent.get(plateau, &Map.get(&1, key))
  end
end
