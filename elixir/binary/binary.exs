defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    case :re.run(string, "^[0-1]*$") do
      {:match, _} ->
          string
          |> String.graphemes
          |> Enum.reverse
          |> Enum.with_index
          |> Enum.reduce(0, fn({s, i}, acc)->
              acc + (String.to_integer(s) * :math.pow(2,i))
          end)
      :nomatch -> 0
    end
  end
end
