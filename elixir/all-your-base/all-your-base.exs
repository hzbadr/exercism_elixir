defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) when digits == [] or base_a <= 1 or base_b <= 1 do
    nil
  end

  def convert(digits, base_a, base_b) do
    cond do
      valid?(digits, base_a) ->
        num = to_number(digits, base_a)
        c = log(num, base_b)
        do_convert(num, base_b, c)
      true -> nil
    end
  end

  defp valid?(digits, base_a) do
    Enum.all?(digits, fn(x) -> x >= 0 && x < base_a end)
  end

  defp to_number(digits, base_a) do
    l = length(digits)
    digits
    |> Enum.with_index
    |> Enum.reduce(0, fn({n, i}, acc) ->
      acc + n * :math.pow(base_a, l - i - 1)
    end)
  end

  defp do_convert(num, base_b, i) do
    cond do
      num < base_b && i <= 1 -> [round(num)]
      i <= 1 -> [0]
      num < base_b && i > 0 -> [0 | do_convert(num, base_b, i-1)]
      true ->
        x = Float.floor(num / :math.pow(base_b, i-1))
        [x | do_convert(num - (x*:math.pow(base_b, i-1)), base_b, i - 1)]
    end
  end

  defp log(num, base_b, c \\ 1) do
    cond do
      num < base_b -> 1
      true -> c + log(num / base_b, base_b, c)
    end
  end
end
