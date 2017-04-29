defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """

  @items %{
          12 => "twelve Drummers Drumming",
          11 => "eleven Pipers Piping",
          10 => "ten Lords-a-Leaping",
          9  => "nine Ladies Dancing",
          8  =>  "eight Maids-a-Milking",
          7  => "seven Swans-a-Swimming",
          6  => "six Geese-a-Laying",
          5  => "five Gold Rings",
          4  =>  "four Calling Birds",
          3  =>  "three French Hens",
          2  => "two Turtle Doves",
          1  => "a Partridge"
  }

  @days  ~w[first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth]

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the " <>
      day(number) <>
        " day of Christmas my true love gave to me, " <>
          Enum.join(items(number, 1), ", ") <> " in a Pear Tree."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&(verse(&1)))
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end

  defp day(number) do
    Enum.at(@days, number - 1)
  end

  defp items(number, stop) do
    item = @items[number]
    cond do
      number < stop || ! item -> []
      number == 2 && stop == 1 -> [item , "and " <> @items[number-1]]
      true ->
        [item | items(number-1, stop)]
    end
  end
end
