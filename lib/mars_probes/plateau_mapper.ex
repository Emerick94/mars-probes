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
        IO.puts(message)
        plateau

      {:ok, new_probe} ->
        Map.put(plateau, :probes, [new_probe | plateau.probes])
    end
  end

  def update_probe(plateau, x, y, direction) do
    updated_probe = %{x: x, y: y, direction: direction}
    update_probe(plateau, updated_probe)
  end

  def update_probe(plateau, %{x: _x, y: _y, direction: direction} = updated_probe) do
    updated_probe =
      Map.replace!(updated_probe, :direction, DirectionHelper.direction_number(direction))

    case DirectionHelper.validate_probe(plateau, updated_probe) do
      {:error, message} ->
        IO.puts(message)
        plateau

      {:ok, updated_probe} ->
        [_old_probe | rest] = plateau.probes
        Map.put(plateau, :probes, [updated_probe | rest])
    end
  end

  def show_probes(plateau) do
    plateau.probes
    |> Enum.reverse()
    |> Enum.map(fn probe ->
      "#{probe.x} #{probe.y} #{DirectionHelper.direction_name(probe.direction)}"
    end)
  end

  def follow_instructions(plateau, "") do
    plateau
  end

  def follow_instructions(plateau, instructions) do
    # TODO split by repeating letters egg "LLMMMRMM" => ["LL", "MMM", "R", "MM"]
    {next_instruction, remainder} =
      instructions
      |> String.next_grapheme()

    plateau
    |> single_instruction(next_instruction)
    |> follow_instructions(remainder)
  end

  def single_instruction(plateau, character) when is_bitstring(character) do
    case String.upcase(character) do
      "L" ->
        turn(plateau, -1)

      "R" ->
        turn(plateau, 1)

      "M" ->
        move(plateau)

      _ ->
        IO.puts("invalid instruction `#{character}`")
        plateau
    end
  end

  def single_instruction(_, _) do
    IO.puts("invalid instruction")
  end

  def turn(plateau, number) when is_integer(number) do
    [probe | _] = plateau.probes
    probe = Map.replace!(probe, :direction, probe.direction + number)
    update_probe(plateau, probe)
  end

  def move(plateau) do
    move(plateau, 1)
  end

  def move(plateau, number) when is_integer(number) do
    [probe | _] = plateau.probes

    probe =
      case probe.direction do
        0 -> Map.replace!(probe, :y, probe.y + number)
        1 -> Map.replace!(probe, :x, probe.x + number)
        2 -> Map.replace!(probe, :y, probe.y - number)
        3 -> Map.replace!(probe, :x, probe.x - number)
      end

    update_probe(plateau, probe)
  end
end
