defmodule Mix.Tasks.Explore do
  use Mix.Task
  import MarsProbes.PlateauMapper

  @shortdoc "helps you explore mars!"

  def run([file_location]) when is_bitstring(file_location) do
    with {:ok, file} <- File.read(file_location) do
      [plateau_size | probe_instructions] = String.split(file, "\n")

      start_plateau(plateau_size)
      |> probe_instructions_parser(probe_instructions)
      |> show_probes
      |> Enum.each(&IO.puts/1)
    else
      {:error, :enoent} ->
        IO.puts("File not found. friendly reminder: \"~\" will not work")

      _ ->
        IO.puts("Unkown error. access https://xkcd.com/2200/ for more information.")
    end
  end

  def run(_) do
    # calling our Hello.say() function from earlier
    IO.puts("Welcome explorer! this project will help you explore mars! ")
    IO.puts("Please note when inputing numbers that only the integer part will be considered")

    plateau_size =
      IO.gets(
        "State te max width(x) and height(y) of the plateau we are working with, as in \"12 25\"."
      )

    plateau = start_plateau(plateau_size)

    first_instruction =
      IO.gets("")
      |> String.trim()

    plateau
    |> probe_controller(first_instruction)
    |> show_probes
    |> Enum.each(&IO.puts/1)
  end

  defp probe_controller(plateau, "") do
    plateau
  end

  defp probe_controller(plateau, instruction) do
    plateau = instructions_follower(plateau, instruction)

    next_instruction =
      IO.gets("")
      |> String.trim()

    probe_controller(plateau, next_instruction)
  end

  defp probe_instructions_parser(plateau, []) do
    plateau
  end

  defp probe_instructions_parser(plateau, list) do
    [current_instruction | rest] = list

    plateau = instructions_follower(plateau, current_instruction)

    probe_instructions_parser(plateau, rest)
  end

  defp instructions_follower(plateau, "") do
    plateau
  end

  defp instructions_follower(plateau, instruction) do
    {key, _} = String.next_grapheme(instruction)

    cond do
      String.match?(key, ~r/^[[:digit:]]/) ->
        add_probe(plateau, instruction)

      String.match?(key, ~r/^[[:alpha:]]/) ->
        follow_instructions(plateau, instruction)

      true ->
        IO.puts("Invalid instruction")
        plateau
    end
  end
end
