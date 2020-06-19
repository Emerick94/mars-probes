defmodule MarsProbes.DirectionHelper do
  @valid_names ["N", "E", "S", "W", "NORTH", "EAST", "SOUTH", "WEST"]
  @directions "NESW"

  def direction_name(direction) do
    case direction_number(direction) do
      number when is_integer(number) ->
        String.at(@directions, number)

      {:error, error_mesage} ->
        {:error, error_mesage}
    end
  end

  def direction_number(number) when is_integer(number) do
    rem(number, 4)
  end

  def direction_number(number) when is_float(number) do
    number
    |> round()
    |> direction_number()
  end

  def direction_number(name) when is_bitstring(name) do
    normalized_name = String.upcase(name)

    if Enum.member?(@valid_names, normalized_name) do
      letter = String.at(normalized_name, 0)
      {number, 1} = :binary.match(@directions, letter)
      number
    else
      {:error, "no direction related to this string."}
    end
  end

  def direction_number(name) when is_atom(name) do
    name
    |> Atom.to_string()
    |> direction_number()
  end

  def direction_number(_invalid) do
    {:error, "this argument is invalid, please use integer, float, string or atom."}
  end
end
