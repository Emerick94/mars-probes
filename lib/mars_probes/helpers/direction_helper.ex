defmodule MarsProbes.DirectionHelper do
  @valid_names ["N", "E", "S", "W", "NORTH", "EAST", "SOUTH", "WEST"]
  @directions "NESW"
  @direction_number %{0 => "N", 1 => "E", 2 => "S", 3 => "W"}

  def direction_name(number) when is_integer(number) do
    direction_name = rem(number, 4)
    Map.get(@direction_number, direction_name)
  end

  def direction_name(number) when is_float(number) do
    number
    |> round()
    |> direction_name()
  end

  def direction_name(name) when is_bitstring(name) do
    normalized_name = String.upcase(name)

    if Enum.member?(@valid_names, normalized_name) do
      String.at(normalized_name, 0)
    else
      {:error, "no direction related to this string"}
    end
  end
end
