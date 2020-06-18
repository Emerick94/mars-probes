defmodule MarsProbes.PlateauMapper do
  use Agent

  @doc """
  Starts a new plateau.
  """
  def start_link(x, y) do
    Agent.start_link(fn ->
      %{
        size: %{x: x, y: y},
        probes: []
      }
    end)
  end

  @doc """
  Deploys a probe to an existing plateau.
  """
  def add_probe(plateau, x, y, direction) do
    # aaa
  end

  @doc """
  Puts the `value` for the given `key` in the `plateau`.
  """
  def put(plateau, key, value) do
    Agent.update(plateau, &Map.put(&1, key, value))
  end

  def get(plateau, key) do
    Agent.get(plateau, &Map.get(&1, key))
  end
end
