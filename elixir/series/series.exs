defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size < 1 do
    []
  end

  def slices(s, size) do
    case String.graphemes(s) do
      x when length(x) >= size ->
        {a, b} = String.split_at(s, size)
        {l, m} = String.split_at(s, 1)
        [a | slices(m, size)]
      _ -> []
    end
  end

end
