defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @arabic_roman [
    {"M", 1000},
    {"CM", 900},
    {"D", 500},
    {"CD", 400},
    {"C", 100},
    {"XC", 90},
    {"L", 50},
    {"XL", 40},
    {"X", 10},
    {"IX", 9},
    {"V", 5},
    {"IV", 4},
    {"I", 1}
  ]


  @spec numerals(pos_integer) :: String.t
  def numerals(number, _) when number == 0 do
    ""
  end
  def numerals(number) do
    numerals(number, @arabic_roman)
  end
  def numerals(number, [{roman, value} | t]) do
    cond do
      number >= value -> roman <> numerals(number - value, @arabic_roman)
      true -> numerals(number, t)
    end
  end
end
