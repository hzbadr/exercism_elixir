defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @factors [{3 , "Pling"}, {5, "Plang"}, {7, "Plong"}]

  @spec convert(pos_integer) :: String.t
  def convert(number) do
    res = Enum.reduce @factors, "", fn({n, s}, res) when rem(number, n) == 0 -> res <> s
        (_, res) -> res
    end
    case res do
      "" -> to_string number
      _ -> res
    end
  end
end