defmodule MarsProbes.PlateauMapper do
  use Agent

  alias MarsProbes.DirectionHelper

  @doc """
  Starts a new plateau.
  """
  def start_plateau(x, y) do
    %{
      size: %{x: x, y: y},
      probes: []
    }
  end

  @doc """
  Deploys a probe to an existing plateau.
  """
  def add_probe(plateau, x, y, direction) do
    normalized_direction = DirectionHelper.direction_number(direction)
    new_probe = %{x: x, y: y, direction: normalized_direction}

    case DirectionHelper.validate_probe(plateau, new_probe) do
      {:error, message} ->
        {:error, message}

      {:ok, new_probe} ->
        {_, plateau} =
          Map.get_and_update(plateau, :probes, fn probes ->
            {probes, [new_probe | probes]}
          end)

        plateau
    end
  end

  def show_probes(plateau) do
    plateau.probes
    |> Enum.reverse()
    |> Enum.map(fn probe ->
      "#{probe.x} #{probe.y} #{DirectionHelper.direction_name(probe.direction)}"
    end)
  end
end
